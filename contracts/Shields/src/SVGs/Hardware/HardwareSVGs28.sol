// SPDX-License-Identifier: The Unlicense

pragma solidity ^0.8.13;

import "../../interfaces/IHardwareSVGs.sol";
import "../../interfaces/ICategories.sol";

/// @dev Experimenting with a contract that holds huuuge svg strings
contract HardwareSVGs28 is IHardwareSVGs, ICategories {
  function hardware_93() public pure returns (HardwareData memory) {
    return
      HardwareData(
        "Two Fleury Hinges Issuant from Dexter",
        HardwareCategories.STANDARD,
        string(
          abi.encodePacked(
            '<defs><linearGradient id="h93-a" x1="0" x2="0" y1="1" y2="0"><stop offset="0" stop-color="gray"/><stop offset="1" stop-color="#fff"/></linearGradient><linearGradient id="h93-f" x1="0" x2="0" xlink:href="#h93-a" y1="1" y2="0"/><linearGradient id="h93-d" x1="1" x2="0" xlink:href="#h93-a" y1="0" y2="0"/><linearGradient id="h93-b" x1="1" x2="0" y1="0" y2="0"><stop offset="0" stop-color="#fff"/><stop offset="1" stop-color="#696969"/></linearGradient><linearGradient id="h93-e" x1="0" x2="1" xlink:href="#h93-b" y1="0" y2="0"/><linearGradient id="h93-c" x1="0" x2="0" xlink:href="#h93-a" y1="1" y2="0"/><linearGradient id="h93-i" x1="0" x2="0" xlink:href="#h93-a" y1="1" y2="0"/><linearGradient id="h93-k" x1="0" x2="1" xlink:href="#h93-b" y1="0" y2="0"/><linearGradient id="h93-l" x1="0" x2="0" xlink:href="#h93-b" y1="0" y2="1"/><linearGradient id="h93-m" x1="0" x2="0" xlink:href="#h93-b" y1="0" y2="1"/><linearGradient id="h93-n" x1="0" x2="0" xlink:href="#h93-b" y1="1" y2="0"/><linearGradient id="h93-o" x1="0" x2="0" xlink:href="#h93-b" y1="0" y2="1"/><linearGradient id="h93-p" x1="0" x2="0" y1="1" y2="0"><stop offset="0" stop-color="#fff"/><stop offset=".5" stop-color="gray"/><stop offset="1" stop-color="#fff"/></linearGradient><symbol id="h93-j" viewBox="0 0 19.84 21.03"><path d="M10.16 0C1.62 0 0 8.89 0 8.89a7.84 7.84 0 0 1 .85-1.05 25.52 25.52 0 0 1 4.22-4c1.45-1.25 8.09-4.3 11.6 1.86S13.93 21 13.92 21s3.56-1.49 3.68-3c5.06-8.5 1.09-18-7.44-18Z" fill="url(#h93-c)"/></symbol><symbol id="h93-q" viewBox="0 0 38.13 32.28"><path d="M17.6 14.23c8.92 3.5 16.5-5.41 20.54-6.71-.63-.2-3.49-.47-4.14 0-6.63 4.75-11.54 7.5-20.08 3.73 1.37 1.42 2.44 3.01 3.68 2.98Z" fill="url(#h93-d)"/><path d="m17.6.81-3.68 3S18.85 2 21.82 2C27.21 2 33.57 7.23 34 7.52h4.14C34.1 6.22 26.52-2.69 17.6.81Z" fill="url(#h93-b)"/><path d="m17.6 14.23-3.68-3s6.61 8.62 2.75 15.38c-3.41 6-10 3.23-11.63 1.85A16.09 16.09 0 0 1 0 23.4s1.62 8.88 10.16 8.88 12.5-9.49 7.44-18.05Z" fill="url(#h93-e)"/></symbol><symbol id="h93-r" viewBox="0 0 7.59 8.94"><path d="M7.59 5.15V3.79H0v1.36l3.79 3.79 3.8-3.79Z"/><path d="M1 3.79 3.79 1l2.8 2.79-2.8 2.8Z" fill="url(#h93-a)"/><path d="M3.79 0 0 3.79l1.77.23L3.79 2l2.12 2.11 1.68-.32L3.79 0z" fill="url(#h93-f)"/><path d="M3.79 7.59 0 3.79h2l1.79 1.8 1.8-1.8h2l-3.8 3.8z" fill="url(#h93-f)"/></symbol><clipPath id="h93-h"><path d="M160 72v75a50 50 0 0 1-100 0V72Z" fill="none"/></clipPath><filter id="h93-g"><feDropShadow dx="0" dy="2" stdDeviation="0"/></filter></defs><g clip-path="url(#h93-h)" filter="url(#h93-g)"><path d="M84 188.52A49.17 49.17 0 0 1 61 147V73h23v8.59c0 10.18 7.15 16.26 14.06 16.26s10.31-4.6 10.31-9.15c0-3.92-2.61-6.66-6.35-6.66a6.3 6.3 0 0 0-2.75.65 8.63 8.63 0 0 1 7.73-4.45 8.14 8.14 0 0 1 7.39 4.16c2 3.46 1.66 8.2-.8 12.38l-1.48 2.5 2.7-1.06a10.55 10.55 0 0 1 3.86-.74c4.38 0 8.36 2.71 11.56 4.9.88.6 1.71 1.16 2.47 1.62-.76.46-1.59 1-2.47 1.62-3.2 2.19-7.17 4.9-11.56 4.9a10.55 10.55 0 0 1-3.86-.74l-2.7-1.06 1.48 2.5c2.46 4.18 2.77 8.92.8 12.38a8.14 8.14 0 0 1-7.39 4.16 8.63 8.63 0 0 1-7.75-4.45 6.3 6.3 0 0 0 2.75.69 6 6 0 0 0 4.75-2.06 7 7 0 0 0 1.6-4.6c0-4.55-3.54-9.15-10.31-9.15S84 112.23 84 122.41v19.18c0 10.18 7.15 16.26 14.06 16.26s10.31-4.6 10.31-9.15c0-3.92-2.61-6.66-6.35-6.66a6.3 6.3 0 0 0-2.75.65 8.61 8.61 0 0 1 7.75-4.45 8.14 8.14 0 0 1 7.39 4.16c2 3.46 1.66 8.2-.8 12.38l-1.48 2.5 2.7-1.06a10.55 10.55 0 0 1 3.86-.74c4.39 0 8.36 2.72 11.56 4.9.88.6 1.71 1.16 2.47 1.62-.76.46-1.59 1-2.47 1.62-3.2 2.19-7.17 4.9-11.56 4.9a10.55 10.55 0 0 1-3.86-.74l-2.7-1.06 1.48 2.5c2.46 4.18 2.77 8.92.8 12.38a8.14 8.14 0 0 1-7.39 4.16 8.61 8.61 0 0 1-7.75-4.45 6.3 6.3 0 0 0 2.73.69c3.74 0 6.35-2.74 6.35-6.66 0-4.55-3.54-9.15-10.31-9.15S84 172.23 84 182.41Z" fill="url(#h93-i)"/><use height="21.03" transform="translate(96.86 77.24)" width="19.84" xlink:href="#h93-j"/><use height="21.03" transform="translate(96.86 137.24)" width="19.84" xlink:href="#h93-j"/><path d="m60 72 .64 2h23.83l.53-2H60z" fill="url(#h93-k)"/><path d="M96.86 86.13S98.8 83 102 83c8 0 7.31 13.81-4 13.81-6.39.04-13-5.81-13-15.22V72l-2 2v7.59c0 10.81 7.66 17.26 15.06 17.26 14.2 0 14.36-17.81 4-17.81-2.52.96-5.2 5.09-5.2 5.09Z" fill="url(#h93-l)"/><path d="M96.86 177.88S98.8 181 102 181c8 0 7.31-13.81-4-13.81-6.39-.04-13 5.81-13 15.22V192l-2-2v-7.59c0-10.81 7.66-17.26 15.06-17.26 14.2 0 14.36 17.81 4 17.81-2.94-.89-5.38-5.05-5.2-5.08Z" fill="url(#h93-m)"/><path d="M96.9 146.07v.06Z" fill="url(#h93-n)"/><path d="M102 141c-2.31.91-4.79 4.53-5.12 5 .28-.41 2.15-3 5.12-3 8 0 7.31 13.81-4 13.81-6.39.04-13-5.81-13-15.22v-19.18c0-9.42 6.61-15.26 13.06-15.26 11.27 0 11.94 13.81 4 13.81-3 0-5.22-3.51-5.12-3 .16.69 2.38 4.59 5.12 5 10.4 0 10.24-17.81-4-17.81-7.4 0-15.06 6.45-15.06 17.26v19.18c0 10.81 7.66 17.26 15.06 17.26 14.2 0 14.36-17.85 3.94-17.85Z" fill="url(#h93-o)"/><path d="M96.9 117.93v-.06ZM83 186.66A48 48 0 0 1 62 147V74l-2-2v120l25-1.71Z" fill="url(#h93-p)"/><use height="32.28" transform="translate(96.86 94.48)" width="38.14" xlink:href="#h93-q"/><use height="32.28" transform="translate(96.86 154.48)" width="38.14" xlink:href="#h93-q"/><use height="8.94" transform="translate(81.21 98.21)" width="7.59" xlink:href="#h93-r"/><use height="8.94" transform="translate(106.21 98.21)" width="7.59" xlink:href="#h93-r"/><use height="8.94" transform="translate(81.21 158.21)" width="7.59" xlink:href="#h93-r"/><use height="8.94" transform="translate(106.21 158.21)" width="7.59" xlink:href="#h93-r"/></g><path d="M110 197a50 50 0 0 1-50-50V72" fill="none"/>'
          )
        )
      );
  }

  function hardware_94() public pure returns (HardwareData memory) {
    return
      HardwareData(
        "Torch",
        HardwareCategories.STANDARD,
        string(
          abi.encodePacked(
            '<defs><linearGradient gradientUnits="userSpaceOnUse" id="h94-a" x1="2.96" x2="2.96" y1="13.48"><stop offset="0" stop-color="#4b4b4b"/><stop offset="0.8" stop-color="#fff"/></linearGradient><linearGradient id="h94-b" x1="3.58" x2="3.58" xlink:href="#h94-a" y1="0" y2="13.48"/><radialGradient cx="21.56" cy="1.26" gradientTransform="translate(39.18 -11.27) rotate(140.18) scale(1 1.31)" gradientUnits="userSpaceOnUse" id="h94-c" r="15.27"><stop offset="0" stop-color="gray"/><stop offset="1" stop-color="#fff"/></radialGradient><clipPath id="h94-d"><path d="M160,72v75a50,50,0,0,1-100,0V72Z" fill="none"/></clipPath><filter id="h94-e" name="shadow"><feDropShadow dx="0" dy="2" stdDeviation="0"/></filter><radialGradient cx="109.98" cy="132" gradientTransform="translate(305.48 194.76) rotate(140.18) scale(1 1.31)" gradientUnits="userSpaceOnUse" id="h94-f" r="64.68"><stop offset="0.25" stop-color="#fff"/><stop offset="1" stop-color="#4b4b4b"/></radialGradient><linearGradient gradientUnits="userSpaceOnUse" id="h94-g" x1="103.81" x2="116.35" y1="171.8" y2="171.8"><stop offset="0" stop-color="gray"/><stop offset="0.24" stop-color="#4b4b4b"/><stop offset="0.68" stop-color="#fff"/><stop offset="1" stop-color="#4b4b4b"/></linearGradient><linearGradient id="h94-h" x1="97.72" x2="119.44" xlink:href="#h94-g" y1="133" y2="133"/><linearGradient gradientUnits="userSpaceOnUse" id="h94-i" x1="97.5" x2="122.5" y1="139.5" y2="139.5"><stop offset="0" stop-color="gray"/><stop offset="0.5" stop-color="#fff"/><stop offset="1" stop-color="gray"/></linearGradient><linearGradient gradientUnits="userSpaceOnUse" id="h94-j" x1="97.5" x2="122.5" y1="137.5" y2="137.5"><stop offset="0" stop-color="#fff"/><stop offset="0.5" stop-color="gray"/><stop offset="1" stop-color="#fff"/></linearGradient><symbol id="h94-k" viewBox="0 0 43.12 2.52"><polygon fill="url(#h94-c)" points="0 0 43.12 0 43.12 2.52 0 0"/></symbol><symbol id="h94-aa" viewBox="0 0 5.92 13.48"><path d="M1.68,0c-4.63,7,1.76,9,2,13.48C9.8,11.19,1.38,4.17,1.68,0Z" fill="url(#h94-a)"/><path d="M1.68,0c-2.3,6.18,5.2,10.06,2,13.48C9.8,11.19,1.38,4.17,1.68,0Z" fill="url(#h94-b)"/></symbol></defs><g clip-path="url(#h94-d)"><g filter="url(#h94-e)"><polygon fill="url(#h94-f)" points="123.45 135 174.66 132 123.45 129 168.56 104.58 120.9 123.58 151.4 82.32 118.16 117.75 132.02 71.2 112.82 115.83 109.98 67.32 107.14 115.83 87.95 71.2 101.8 117.76 68.56 82.32 99.06 123.57 51.41 104.58 96.52 129 45.3 132 96.52 135 51.41 159.43 99.06 140.43 68.57 181.68 101.8 146.25 87.95 192.81 107.14 148.16 109.98 196.68 112.82 148.16 132.02 192.81 118.17 146.25 151.39 181.68 120.9 140.42 168.56 159.43 123.45 135"/><use height="2.52" transform="translate(45.31 132) scale(1.5)" width="43.12" xlink:href="#h94-k"/><use height="2.52" transform="translate(110 67.31) rotate(90) scale(1.5)" width="43.12" xlink:href="#h94-k"/><use height="2.52" transform="translate(51.41 104.56) rotate(25.1) scale(1.5)" width="43.12" xlink:href="#h94-k"/><use height="2.52" transform="matrix(0.96, 1.15, -1.15, 0.96, 68.58, 82.3)" width="43.12" xlink:href="#h94-k"/><use height="2.52" transform="translate(87.97 71.17) rotate(70.09) scale(1.5)" width="43.12" xlink:href="#h94-k"/><use height="2.52" transform="matrix(-1.5, 0, 0, 1.5, 174.69, 132)" width="43.12" xlink:href="#h94-k"/><use height="2.52" transform="matrix(-1.36, 0.64, 0.64, 1.36, 168.59, 104.56)" width="43.12" xlink:href="#h94-k"/><use height="2.52" transform="matrix(-0.96, 1.15, 1.15, 0.96, 151.42, 82.3)" width="43.12" xlink:href="#h94-k"/><use height="2.52" transform="matrix(-0.51, 1.41, 1.41, 0.51, 132.03, 71.17)" width="43.12" xlink:href="#h94-k"/><use height="2.52" transform="translate(110 196.7) rotate(-90) scale(1.5)" width="43.12" xlink:href="#h94-k"/><use height="2.52" transform="translate(168.59 159.44) rotate(-154.9) scale(1.5)" width="43.12" xlink:href="#h94-k"/><use height="2.52" transform="matrix(-0.96, -1.15, 1.15, -0.96, 151.42, 181.7)" width="43.12" xlink:href="#h94-k"/><use height="2.52" transform="translate(132.03 192.83) rotate(-109.91) scale(1.5)" width="43.12" xlink:href="#h94-k"/><use height="2.52" transform="matrix(1.36, -0.64, -0.64, -1.36, 51.41, 159.44)" width="43.12" xlink:href="#h94-k"/><use height="2.52" transform="matrix(0.96, -1.15, -1.15, -0.96, 68.58, 181.7)" width="43.12" xlink:href="#h94-k"/><use height="2.52" transform="matrix(0.51, -1.41, -1.41, -0.51, 87.97, 192.83)" width="43.12" xlink:href="#h94-k"/><use height="13.48" transform="translate(111.93 106.19) scale(1.84)" width="5.93" xlink:href="#h94-aa"/><use height="13.48" transform="translate(104.04 97.33) scale(2.5)" width="5.93" xlink:href="#h94-aa"/><use height="13.48" transform="translate(107.15 110.78) scale(1.5)" width="5.93" xlink:href="#h94-aa"/><use height="13.48" transform="translate(99.82 106.19) scale(2.01)" width="5.93" xlink:href="#h94-aa"/><use height="13.48" transform="translate(100.41 118.75) scale(1.1)" width="5.93" xlink:href="#h94-aa"/><use height="13.48" transform="translate(113.93 119.77)" width="5.93" xlink:href="#h94-aa"/><use height="13.48" transform="translate(96.04 116.57) scale(1.29)" width="5.93" xlink:href="#h94-aa"/><use height="13.48" transform="translate(109.18 122.29) scale(0.81)" width="5.93" xlink:href="#h94-aa"/><path d="M98.5,135c5.85,4.18,6.88,14.78,7.09,19.75.42,10.44,2.41,53.84,2.41,53.84h4s2-43.4,2.41-53.84c.21-5,1.24-15.57,7.09-19.75Z" fill="url(#h94-g)"/><rect fill="url(#h94-h)" height="2" width="25" x="97.5" y="132"/><path d="M117.42,144l-1.28,1h-12.3l-1.27-1ZM97.5,134l1,1h23l1-1Z" fill="url(#h94-i)"/><path d="M115.42,146H104.56l-.72-1h12.3ZM98.5,135l1.19,1h20.62l1.19-1Z"/><path d="M102.57,144l1.27-1h12.3l1.28,1Zm19.93-12-1-1h-23l-1,1Z" fill="url(#h94-j)"/></g></g>'
          )
        )
      );
  }

  function hardware_95() public pure returns (HardwareData memory) {
    return
      HardwareData(
        "Sun and Moon",
        HardwareCategories.STANDARD,
        string(
          abi.encodePacked(
            '<defs><linearGradient gradientTransform="matrix(1, 0, 0, -1, 0, 16394.73)" gradientUnits="userSpaceOnUse" id="h95-a" x1="10.73" x2="10.73" y1="16383.81" y2="16388.96"><stop offset="0" stop-color="#fff"/><stop offset="1" stop-color="#4b4b4b"/></linearGradient><linearGradient gradientTransform="matrix(1, 0, 0, -1, 0, 16394.73)" gradientUnits="userSpaceOnUse" id="h95-b" x1="4.62" x2="20.09" y1="16391.86" y2="16385.5"><stop offset="0" stop-color="#4b4b4b"/><stop offset="0.49" stop-color="#fff"/><stop offset="1" stop-color="#4b4b4b"/></linearGradient><linearGradient gradientTransform="matrix(1, 0, 0, -1, 0, 16394.73)" gradientUnits="userSpaceOnUse" id="h95-c" x1="4.04" x2="20.28" y1="16394.14" y2="16386.35"><stop offset="0" stop-color="#fff"/><stop offset="0.49" stop-color="#4b4b4b"/><stop offset="1" stop-color="#fff"/></linearGradient><linearGradient gradientTransform="matrix(1, 0, 0, 1, 0, 0)" id="h95-d" x1="17.71" x2="17.71" xlink:href="#h95-a" y1="9.13" y2="20.57"/><linearGradient gradientUnits="userSpaceOnUse" id="h95-e" x1="21.98" x2="30.49" y1="16.67" y2="16.67"><stop offset="0" stop-color="gray"/><stop offset="1" stop-color="#fff"/></linearGradient><linearGradient id="h95-f" x1="17.71" x2="17.71" xlink:href="#h95-e" y1="33.06" y2="2.37"/><filter id="h95-g" name="shadow"><feDropShadow dx="0" dy="2" stdDeviation="0"/></filter><linearGradient gradientTransform="matrix(1, 0, 0, -1, 0, 264)" gradientUnits="userSpaceOnUse" id="h95-h" x1="72.5" x2="147.5" y1="109.02" y2="109.02"><stop offset="0" stop-color="#fff"/><stop offset="0.5" stop-color="#4b4b4b"/><stop offset="1" stop-color="#fff"/></linearGradient><linearGradient gradientTransform="matrix(1, 0, 0, -1, 0, 264)" gradientUnits="userSpaceOnUse" id="h95-i" x1="76.25" x2="143.75" y1="117.32" y2="117.32"><stop offset="0" stop-color="gray"/><stop offset="0.5" stop-color="#fff"/><stop offset="1" stop-color="gray"/></linearGradient><linearGradient id="h95-j" x1="82.38" x2="82.38" xlink:href="#h95-e" y1="120.12" y2="120.12"/><linearGradient id="h95-k" x1="110" x2="110" xlink:href="#h95-e" y1="122.42" y2="174.9"/><symbol id="h95-m" viewBox="0 0 21.47 10.73"><path d="M21.47,10.73A36.77,36.77,0,0,0,10.61,7.79h0L0,10.73H21.47Z" fill="url(#h95-a)"/><path d="M21.47,10.73c-3.26-5.8-8.51-5.36-13.71-9C6.08.77,4.29,2.58,2.88,0c.65,3.06,2.64,2.28,3.93,3S7.7,6.13,9.68,7.35a4.68,4.68,0,0,0,.93.44Z" fill="url(#h95-b)"/><path d="M8,2.28c1.49.87.91,2.14,3.2,3.46s6.91-.84,10.28,5c-1.84-3.17-3.77-5.85-7.77-7.1a2.67,2.67,0,0,1-1.91,0C10.17,2.65,10.42,2.07,8.49,1S4.85,2.61,2.88,0C3.86,3,6.31,1.32,8,2.28Z" fill="url(#h95-c)"/></symbol><symbol id="h95-l" viewBox="0 0 35.43 35.43"><path d="M9.43,20.34,0,17.72a109.07,109.07,0,0,1,17.71,0C11.7,17.72,9.43,20.34,9.43,20.34Zm17.24-.19,8.76-2.43H17.71Z" fill="url(#h95-d)"/><path d="M26,15.09l9.43,2.63a74,74,0,0,1-17.72,0C23.73,17.72,26,15.09,26,15.09Z" fill="url(#h95-e)"/><path d="M11.3,11.85,8.86,2.37a72.76,72.76,0,0,1,8.85,15.35C14.71,12.5,11.3,11.85,11.3,11.85Zm8.29-2.62,7-6.86a83,83,0,0,1-8.86,15.35C20.72,12.5,19.59,9.23,19.59,9.23Zm4.54,14.35,2.44,9.48a59.19,59.19,0,0,1-8.86-15.34C20.72,22.93,24.13,23.58,24.13,23.58ZM15.84,26.2l-7,6.86a92.44,92.44,0,0,1,8.85-15.34C14.71,22.93,15.84,26.2,15.84,26.2Z" fill="url(#h95-f)"/><use height="10.73" transform="translate(0 8.86) scale(0.83)" width="21.47" xlink:href="#h95-m"/><use height="10.73" transform="translate(16.53 -2.06) rotate(60) scale(0.83)" width="21.47" xlink:href="#h95-m"/><use height="10.73" transform="translate(34.24 6.8) rotate(120) scale(0.83)" width="21.47" xlink:href="#h95-m"/><use height="10.73" transform="translate(35.43 26.57) rotate(180) scale(0.83)" width="21.47" xlink:href="#h95-m"/><use height="10.73" transform="translate(18.9 37.49) rotate(-120) scale(0.83)" width="21.47" xlink:href="#h95-m"/><use height="10.73" transform="matrix(0.41, -0.71, 0.71, 0.41, 1.19, 28.63)" width="21.47" xlink:href="#h95-m"/></symbol></defs><g filter="url(#h95-g)"><path d="M140.69,125.47c2,4.27,2.23,9,2.23,13.84a32.92,32.92,0,0,1-65.84,0c0-4.88.27-9.57,2.23-13.84a37.5,37.5,0,1,0,61.38,0Z" fill="url(#h95-h)"/><path d="M137.62,120.12a30.38,30.38,0,1,1-55.24,0,33.75,33.75,0,1,0,55.24,0Z" fill="url(#h95-i)"/><polygon fill="url(#h95-j)" points="82.38 120.12 82.38 120.12 82.38 120.12 82.38 120.12"/><path d="M139.05,122.43A35.65,35.65,0,0,1,143.22,139c0,18.46-13.57,33.42-33.22,33.42s-33.22-15-33.22-33.42A35.61,35.61,0,0,1,81,122.42a36,36,0,0,0-4.7,17.8C76.26,159.37,90,174.9,110,174.9s33.74-15.53,33.74-34.68A36,36,0,0,0,139.05,122.43Z" fill="url(#h95-k)"/><use height="35.43" transform="translate(92.28 84.28)" width="35.43" xlink:href="#h95-l"/></g>'
          )
        )
      );
  }
}
