/* eslint-disable @typescript-eslint/restrict-plus-operands */

const EventEmitter = require("events");
const http = require("http");

async function serve(handler) {
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
    }

    res.writeHead(404);
    res.end("Not found: " + req.url);
  }
  const server = http.createServer(requestListener);
  await new Promise(resolve => {
    return server.listen(9901, resolve);
  });

  return {
    notify: () => {
      return events.emit("change");
    },
  };
}

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

module.exports = serve;
