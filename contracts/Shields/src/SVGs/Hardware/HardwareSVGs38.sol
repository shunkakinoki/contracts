// SPDX-License-Identifier: The Unlicense

pragma solidity ^0.8.13;

import "../../interfaces/IHardwareSVGs.sol";
import "../../interfaces/ICategories.sol";

/// @dev Experimenting with a contract that holds huuuge svg strings
contract HardwareSVGs38 is IHardwareSVGs, ICategories {
  function hardware_118() public pure returns (HardwareData memory) {
    return
      HardwareData(
        "Shields Bracket",
        HardwareCategories.SPECIAL,
        string(
          abi.encodePacked(
            '<defs><linearGradient gradientUnits="userSpaceOnUse" id="h118-a" x1="6" x2="6" y2="8.15"><stop offset="0" stop-color="gray"/><stop offset="1" stop-color="#fff"/></linearGradient><linearGradient id="h118-b" x1="19.65" x2="19.65" xlink:href="#h118-a" y1="96.56" y2="119.32"/><linearGradient id="h118-c" x1="23.96" x2="23.96" xlink:href="#h118-a" y1="36.54" y2="61.54"/><linearGradient id="h118-d" x1="25.7" x2="25.7" xlink:href="#h118-a" y1="7.27" y2="57.8"/><linearGradient id="h118-e" x1="24" x2="24" xlink:href="#h118-a" y1="6.1" y2="28.54"/><linearGradient id="h118-f" x1="3.33" x2="44.75" xlink:href="#h118-a" y1="76.04" y2="76.04"/><linearGradient id="h118-g" x1="37.19" x2="37.19" xlink:href="#h118-a" y1="67.28" y2="107.09"/><linearGradient id="h118-h" x1="10" x2="10" xlink:href="#h118-a" y1="67.27" y2="117.3"/><linearGradient gradientUnits="userSpaceOnUse" id="h118-i" x1="25.03" x2="25.03" y1="63.54" y2="70.98"><stop offset="0" stop-color="#4b4b4b"/><stop offset="1" stop-color="gray"/></linearGradient><linearGradient id="h118-j" x1="25.36" x2="25.36" xlink:href="#h118-i" y1="0.67" y2="11.26"/><linearGradient id="h118-k" x1="22.33" x2="22.33" xlink:href="#h118-a" y1="61.54" y2="55.37"/><linearGradient id="h118-l" x1="4" x2="4" xlink:href="#h118-a" y1="118.48" y2="127.18"/><linearGradient gradientUnits="userSpaceOnUse" id="h118-m" x1="39.95" x2="49.95" y1="1.77" y2="1.77"><stop offset="0" stop-color="#fff"/><stop offset="0.5" stop-color="#c3c3c3"/><stop offset="1" stop-color="#fff"/></linearGradient><linearGradient id="h118-n" x1="49.17" x2="49.17" xlink:href="#h118-a" y1="52.2" y2="76.51"/><linearGradient id="h118-o" x1="48.97" x2="48.97" xlink:href="#h118-a" y1="1.59" y2="12.92"/><linearGradient id="h118-p" x1="1.23" x2="1.23" xlink:href="#h118-a" y1="114.54" y2="117.3"/><clipPath id="h118-q"><path d="M160,72v75a50,50,0,0,1-100,0V72Z" fill="none"/></clipPath><filter id="h118-r" name="shadow"><feDropShadow dx="0" dy="2" stdDeviation="0"/></filter><linearGradient id="h118-s" x1="110" x2="110" xlink:href="#h118-a" y1="196.33" y2="72.49"/><linearGradient id="h118-t" x1="109.92" x2="109.92" xlink:href="#h118-i" y1="195.68" y2="197.85"/><linearGradient id="h118-u" x1="100.64" x2="119.36" xlink:href="#h118-m" y1="70.89" y2="70.89"/><symbol id="h118-w" viewBox="0 0 12 8.15"><path d="M12,0V8.15l-2-.84V.84ZM0,8.15l2-.84V.84L0,0Z" fill="url(#h118-a)"/></symbol><symbol id="h118-v" viewBox="0 0 51.41 127.18"><polygon fill="url(#h118-b)" points="26.04 96.56 21.96 96.56 3 119.31 4.68 118.86 21.6 98.56 26.4 98.56 35.29 109.23 35.29 111.91 36.29 110.06 36.29 108.86 26.04 96.56"/><path d="M21.66,38.37,4.87,58.52l-1.62.38L21.88,36.54Zm23,20.53L26,36.54l.18,1.78L43,58.4Zm-2.56,1.64H5.77l-1.39,1H43.54Z" fill="url(#h118-c)"/><path d="M18.31,28.82,1.66,8.88,1,9.16V55.79l.77.27,16.52-19.8L20,35.77,1.62,57.8l-.27-1.62L0,57.12V8l1.62-.69L20,29.29Zm11.43,7.47L46,55.79l5.41-2.26-1.89,3L46.38,57.8,28,35.77Zm-1.74-7,18.38-22L46.3,8.93,29.79,28.71Z" fill="url(#h118-d)"/><path d="M26,28.54H22L3.33,6.16l1.52.26,17,20.45h4.24L43.42,6.1l1.25.06Z" fill="url(#h118-e)"/><path d="M4.46,63.54H43.62l-1.39,1H5.85ZM22,87,4.85,66.43l-1.52-.27L22,88.54Zm4,1.5L44.75,66.16l-1.52.27L26,87Z" fill="url(#h118-f)"/><path d="M28,89.29l18.38-22L46.2,69,29.79,88.7Zm0,6.48,9.42,11.32h1.65l1-1H37.89L29.83,96.4Z" fill="url(#h118-g)"/><path d="M2.06,117.3,20,95.77,18.5,96,2.06,115.74Zm-1.06-2v-46L0,68v48.31Zm19-26-18.38-22,0,1.62L18.31,88.82Z" fill="url(#h118-h)"/><path d="M38.07,107.09c-.57.75-1.17,1.49-1.78,2.21l-2.5,6.52,9.27-11.27Z" fill="gray"/><path d="M4.46,63.54l1.75,1-1,2.32-1.88-.7Zm39.16,0-1.75,1,1,2.32,1.88-.7Zm2.76,3.74-.38,2L50.06,71,48.5,68.16ZM0,68l1,1.75,1-.42-.38-2Z" fill="url(#h118-i)"/><path d="M1.62,7.27l.38,2L1,9.71,0,8ZM46,9.29l4.73,2-.5-2.38L46.38,7.27M44.67,6.16,42.39.67,41,2.55l1.79,4.31m-37.58,0L7,2.55,5.49,1,3.33,6.16" fill="url(#h118-j)"/><use height="8.15" transform="matrix(1, 0, 0, -1, 18, 96.6)" width="12" xlink:href="#h118-w"/><use height="8.15" transform="matrix(1, 0, 0, -1, 18, 36.6)" width="12" xlink:href="#h118-w"/><path d="M5.13,58.21l1,2.33-1.75,1L3.25,58.9Zm37.66,0-1,2.33,1.75,1,1.13-2.64ZM2,55.79l-1-.42L0,57.12l1.62.68Z" fill="url(#h118-k)"/><polygon fill="gray" points="26.04 36.54 26.4 38.54 21.52 38.54 21.88 36.54 26.04 36.54"/><polygon fill="gray" points="21.96 96.56 21.6 98.56 26.4 98.56 26.04 96.56 21.96 96.56"/><polygon fill="url(#h118-l)" points="3 119.31 3 126.38 5 127.18 5 118.48 3 119.31"/><polygon fill="url(#h118-m)" points="49.95 1.59 48.5 3.54 43.58 3.54 41 2.55 39.95 0 49.95 1.59"/><polygon fill="#fff" points="21.96 88.54 26.03 88.54 26.4 86.54 21.6 86.54 21.96 88.54"/><polygon fill="#fff" points="21.96 28.54 26.03 28.54 26.4 26.54 21.6 26.54 21.96 28.54"/><path d="M48,57.12V68l2.34,6V51.08Z" fill="url(#h118-n)"/><polygon fill="url(#h118-o)" points="49.95 1.59 49.92 12.92 48 7.96 48 3.54 49.95 1.59"/><polygon fill="url(#h118-p)" points="1 114.54 0 116.27 2.06 117.3 2.46 115.27 1 114.54"/></symbol></defs><g clip-path="url(#h118-q)"><g filter="url(#h118-r)"><path d="M156.85,78.14l2.65,1.1V72.49h-6.75l1.62,3.91L137.63,96.49h-5.26L115.63,76.4l1.62-3.91h-14.5l1.62,3.91L87.63,96.49H82.37L65.63,76.4l1.62-3.91H60.5v6.75l2.65-1.1L79.5,97.73v8.51l-16.35,19.6-2.65-1.1v14.5l2.65-1.1L79.5,157.73v8.51L71.34,176H69.93a50.74,50.74,0,0,0,3.28,4v-1.6l9.16-11h5.26l16.87,20.24v8.6h11v-8.58l16.87-20.24h5.26l9.16,11v1.58a50.74,50.74,0,0,0,3.28-4h-1.41l-8.16-9.8v-8.51l16.35-19.59,2.65,1.1v-14.5l-2.65,1.1-16.35-19.6V97.73Zm-45.35.69,1.65-.69L129.5,97.73v8.52l-16.35,19.59-1.65-.69ZM82.37,107.49h5.26l16.74,20.09-1.25,2.91H66.8l-1.25-2.91Zm0,49-16.74-20.1,1.25-2.9H103.2l1.25,2.9-16.74,20.1ZM108.5,184.3l-2.09,1L90.5,166.24v-8.51l16.35-19.59,1.65.69Zm0-59.15-1.65.69L90.5,106.24V97.73l16.35-19.59,1.65.69Zm21,41.09-15.91,19.1-2.09-1V138.83l1.65-.69,16.35,19.59Zm8.13-9.75h-5.26l-16.74-20.1,1.25-2.9H153.2l1.25,2.91Zm16.74-28.91-1.25,2.91H116.8l-1.25-2.91,16.74-20.09h5.34Z" fill="url(#h118-s)"/><path d="M115.63,195.68A49.92,49.92,0,0,1,110,196a47.64,47.64,0,0,1-5.5-.31l-1.14,2.14,13.11,0Z" fill="url(#h118-t)"/><use height="127.18" transform="translate(111 69.45)" width="51.41" xlink:href="#h118-v"/><use height="127.18" transform="matrix(-1, 0, 0, 1, 109, 69.45)" width="51.41" xlink:href="#h118-v"/><polygon fill="url(#h118-u)" points="100.64 68.79 102 72 104.58 72.99 115.42 72.99 118 72 119.36 68.79 100.64 68.79"/></g></g>'
          )
        )
      );
  }

  function hardware_119() public pure returns (HardwareData memory) {
    return
      HardwareData(
        "The Book of Shields",
        HardwareCategories.SPECIAL,
        string(
          abi.encodePacked(
            '<defs><radialGradient cx="1.45" cy="2.32" gradientUnits="userSpaceOnUse" id="h119-a" r="2.9"><stop offset="0" stop-color="gray"/><stop offset="0.5" stop-color="#fff"/><stop offset="0.6" stop-color="#4b4b4b"/><stop offset="1" stop-color="gray"/></radialGradient><linearGradient gradientUnits="userSpaceOnUse" id="h119-b" x1="82.59" x2="87.28" y1="129.23" y2="129.23"><stop offset="0" stop-color="gray"/><stop offset="0.2" stop-color="#4b4b4b"/><stop offset="0.8" stop-color="#fff"/><stop offset="1" stop-color="gray"/></linearGradient><linearGradient gradientUnits="userSpaceOnUse" id="h119-c" x1="108.52" x2="108.52" y1="160.58" y2="97.08"><stop offset="0" stop-color="#fff"/><stop offset="0.5" stop-color="gray"/><stop offset="1" stop-color="#fff"/></linearGradient><linearGradient gradientUnits="userSpaceOnUse" id="h119-d" x1="84" x2="135" y1="160.35" y2="160.35"><stop offset="0" stop-color="#4b4b4b"/><stop offset="1" stop-color="#fff"/></linearGradient><linearGradient gradientUnits="userSpaceOnUse" id="h119-e" x1="109.11" x2="109.11" y1="155.68" y2="165.02"><stop offset="0" stop-color="gray"/><stop offset="1" stop-color="#fff"/></linearGradient><linearGradient id="h119-f" x1="111.22" x2="111.22" xlink:href="#h119-e" y1="153.97" y2="98.82"/><linearGradient gradientUnits="userSpaceOnUse" id="h119-g" x1="134.71" x2="137.14" y1="126.46" y2="126.46"><stop offset="0" stop-color="gray"/><stop offset="0.5" stop-color="#fff"/><stop offset="1" stop-color="gray"/></linearGradient><linearGradient id="h119-h" x1="87.36" x2="87.36" xlink:href="#h119-e" y1="97.08" y2="155.63"/><symbol id="h119-i" viewBox="0 0 2.9 2.9"><path d="M0,1.45A1.45,1.45,0,1,1,1.45,2.9h0A1.45,1.45,0,0,1,0,1.45Z" fill="url(#h119-a)"/></symbol></defs><path d="M82.56,156.93H135a0,0,0,0,1,0,0v11a0,0,0,0,1,0,0H87.28a4.72,4.72,0,0,1-4.72-4.72v-6.31A0,0,0,0,1,82.56,156.93Z"/><path d="M82.6,160.57l4.68-3.68v-59H85s-2.64,2.31-2.41,5.18Z" fill="url(#h119-b)"/><path d="M135,157.34V97.08H86a3.93,3.93,0,0,0-4,3.9,4,4,0,0,0,.59,2.1S83.1,98.8,86,98.8v13.34a3.92,3.92,0,0,0-3.37,6s.47-4.27,3.37-4.27V142a3.92,3.92,0,0,0-3.37,6s.47-4.27,3.37-4.27v10.87a3.93,3.93,0,0,0-4,3.9,4,4,0,0,0,.59,2.1C85.05,153.28,134.72,157.43,135,157.34Z" fill="url(#h119-c)"/><path d="M135,163.77H84v-6.84h51a4.65,4.65,0,0,0,0,6.84Z" fill="url(#h119-d)"/><path d="M135.7,156.93H87.28c-1.11,0-3.55.33-3.55,3.42s2.44,3.42,3.55,3.42h48.45" fill="none" stroke="url(#h119-e)" stroke-width="2.5"/><use height="2.9" transform="translate(130.27 151.03)" width="2.9" xlink:href="#h119-i"/><use height="2.9" transform="translate(89.27 151.03)" width="2.9" xlink:href="#h119-i"/><use height="2.9" transform="translate(130.27 99.03)" width="2.9" xlink:href="#h119-i"/><use height="2.9" transform="translate(89.27 99.03)" width="2.9" xlink:href="#h119-i"/><polygon fill="url(#h119-f)" points="133.61 107.93 133.61 106.08 126.41 98.82 96.07 98.88 88.83 106.08 88.83 146.76 96.05 153.97 126.4 153.97 133.61 146.76 133.61 144.91 129.15 141.22 133.61 136.76 133.61 116.08 129.15 112.39 133.61 107.93"/><path d="M137.14,136.77V145a1.38,1.38,0,0,1-1.21,1.48,1.36,1.36,0,0,1-1.21-1.48v-8.19a1.36,1.36,0,0,1,1.21-1.48A1.38,1.38,0,0,1,137.14,136.77Zm-1.21-30.3a1.35,1.35,0,0,0-1.21,1.47v8.2a1.35,1.35,0,0,0,1.21,1.47,1.37,1.37,0,0,0,1.21-1.47v-8.2A1.37,1.37,0,0,0,135.93,106.47Z" fill="url(#h119-g)"/><path d="M87.36,155.63V97.08" fill="none" stroke="url(#h119-h)"/><path d="M120.12,114.53h0l.43,1-3.94,4.73h-1.15l-3.94-4.73.43-1Zm.19,13.94.24-.55-3.94-4.69h-1.15L111.52,128l.22.55Zm-9.56-12.33-.24.12v11l.24.1,3.84-4.58v-2Zm-1.2,11.09v-11l-.26-.12-3.82,4.62v2l3.82,4.59Zm-6.1-4L99.51,128l.21.55h8.58l.24-.55-3.94-4.74Zm14,12v2l1.9,2.26h.5a12,12,0,0,0,2.16-6.85V131l-.74-.31Zm-14.9,0-3.84-4.61-.72.31v1.68a11.71,11.71,0,0,0,2.14,6.85h.52l1.9-2.26Zm14.9-14.41v2l3.82,4.59.74-.29V116.46l-.74-.32Zm1.27,19.41-2.14-2.57h-1.15l-4,4.78v1.73l.51.29a11.91,11.91,0,0,0,6.77-3.58Zm-2.14-5.45,3.94-4.74-.24-.55h-8.57l-.22.55,3.94,4.74Zm-8,9.39v-1.73l-4-4.77h-1.15l-2.14,2.57v.65a12.06,12.06,0,0,0,6.77,3.58Zm6-8.94-3.84-4.61-.24.12V141.5l.34.17,3.74-4.47Zm-5,6.27V130.68l-.26-.12-3.82,4.61v2l3.72,4.47ZM98.74,127.32l3.84-4.59v-2l-3.84-4.62-.72.32V127Zm5.86,7.4,3.94-4.74-.24-.55H99.72l-.21.55,3.94,4.74Zm-4.66-20.19h0l-.43,1,3.94,4.73h1.15l3.94-4.73-.43-1ZM126.4,154l7.21-7.21v1L126.4,155H96.05l-7.22-7.21v-1L96.05,154Zm3.3-41.13,3.91-3.91v-1l-4.46,4.46Zm0,28.83,3.91-3.91v-1l-4.46,4.46Z" fill="#fff"/><path d="M129.15,112.39l4.46,3.69v1l-4.46-3.69Zm0,29.83,4.46,3.69v-1l-4.46-3.69Zm-2.74-43.4-30.34.06-7.24,7.2v1l7.24-7.2,30.34-.06,7.2,7.26v-1Zm-6.29,14.71h0l.43,1-3.94,4.73h-1.15l-3.94-4.73.43-1Zm.19,13.94.24-.55-3.94-4.69h-1.15L111.52,127l.22.55Zm-9.56-12.33-.24.12v11l.24.1,3.84-4.58v-2Zm-1.2,11.09v-11l-.26-.12-3.82,4.62v2l3.82,4.59Zm-6.1-4L99.51,127l.21.55h8.58l.24-.55-3.94-4.74Zm14,12v2l1.9,2.26h.5a12,12,0,0,0,2.16-6.85V130l-.74-.31Zm-14.9,0-3.84-4.61-.72.31v1.68a11.71,11.71,0,0,0,2.14,6.85h.52l1.9-2.26Zm14.9-14.41v2l3.82,4.59.74-.29V115.46l-.74-.32Zm1.27,19.41-2.14-2.57h-1.15l-4,4.78v1.73l.51.29a11.91,11.91,0,0,0,6.77-3.58Zm-2.14-5.45,3.94-4.74-.24-.55h-8.57l-.22.55,3.94,4.74Zm-8,9.39v-1.73l-4-4.77h-1.15l-2.14,2.57v.65a12.06,12.06,0,0,0,6.77,3.58Zm6-8.94-3.84-4.61-.24.12V140.5l.34.17,3.74-4.47Zm-5,6.27V129.68l-.26-.12-3.82,4.61v2l3.72,4.47ZM98.74,126.32l3.84-4.59v-2l-3.84-4.62-.72.32V126Zm5.86,7.4,3.94-4.74-.24-.55H99.72l-.21.55,3.94,4.74Zm-4.66-20.19h0l-.43,1,3.94,4.73h1.15l3.94-4.73-.43-1Z"/>'
          )
        )
      );
  }

  function hardware_120() public pure returns (HardwareData memory) {
    return
      HardwareData(
        "Three Shields",
        HardwareCategories.SPECIAL,
        string(
          abi.encodePacked(
            '<defs><linearGradient gradientUnits="userSpaceOnUse" id="h120-a" x1="25.46" x2="-11.37" y1="2.5" y2="40.4"><stop offset="0" stop-color="#fff"/><stop offset="1" stop-color="#696969"/></linearGradient><linearGradient gradientUnits="userSpaceOnUse" id="h120-b" x1="14.48" x2="14.48" y1="1.3" y2="34.87"><stop offset="0" stop-color="#595959"/><stop offset="0.8" stop-color="#fff"/><stop offset="0.87" stop-color="#c9c9c9"/><stop offset="0.96" stop-color="#8f8f8f"/><stop offset="1" stop-color="#787878"/></linearGradient><filter id="h120-c" name="shadow"><feDropShadow dx="0" dy="2" stdDeviation="0"/></filter><symbol id="h120-d" viewBox="0 0 28.96 36.2"><path d="M29,0V21.72a14.48,14.48,0,1,1-29,0V0Z" fill="url(#h120-a)"/><polygon fill="#fff" points="0 0 2 2 26.96 2 28.96 0 0 0"/><path d="M27,2V21.72a12.48,12.48,0,0,1-25,0V2L0,0V21.72a14.48,14.48,0,1,0,29,0V0Z" fill="url(#h120-b)"/></symbol></defs><g filter="url(#h120-c)"><use height="36.2" transform="translate(75.46 95.1)" width="28.96" xlink:href="#h120-d"/><use height="36.2" transform="translate(115.58 95.1)" width="28.96" xlink:href="#h120-d"/><use height="36.2" transform="translate(95.52 140.5)" width="28.96" xlink:href="#h120-d"/></g>'
          )
        )
      );
  }
}
