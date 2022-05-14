/* eslint-disable @typescript-eslint/ban-ts-comment */
/* eslint-disable @typescript-eslint/restrict-plus-operands */

import EventEmitter from "events";
import http from "http";

export const serve = async handler => {
  const events = new EventEmitter();

  function requestListener(req, res) {
    if (req.url === "/changes") {
      res.setHeader("Content-Type", "text/event-stream");
      res.writeHead(200);
      const sendEvent = () => {
        return res.write("event: change\ndata:\n\n");
      };
      events.on("change", sendEvent);
      req.on("close", () => {
        return events.off("change", sendEvent);
      });
      return;
    }

    if (req.url === "/") {
      res.writeHead(200);
      handler().then(
        content => {
          return res.end(webpage(content));
        },
        error => {
          return res.end(webpage(`<pre>${error.message}</pre>`));
        },
      );
      return;
    } else {
      res.writeHead(200);
      handler(req.url.replace("/", "")).then(
        content => {
          return res.end(webpage(content));
        },
        error => {
          return res.end(webpage(`<pre>${error.message}</pre>`));
        },
      );
      return;
    }
  }
  const server = http.createServer(requestListener);
  await new Promise(resolve => {
    //@ts-expect-error
    return server.listen(9901, resolve);
  });

  return {
    notify: () => {
      return events.emit("change");
    },
  };
};

const webpage = content => {
  return `
<html>
<title>Hot Chain SVG</title>
${content}
<script>
const sse = new EventSource('/changes');
sse.addEventListener('change', () => window.location.reload());
</script>
</html>
`;
};
