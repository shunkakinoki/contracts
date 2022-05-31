// SPDX-License-Identifier: The Unlicense

pragma solidity ^0.8.13;

import "../../interfaces/IHardwareSVGs.sol";
import "../../interfaces/ICategories.sol";

/// @dev Experimenting with a contract that holds huuuge svg strings
contract HardwareSVGs35 is IHardwareSVGs, ICategories {
  function hardware_112() public pure returns (HardwareData memory) {
    return
      HardwareData(
        "Tracery",
        HardwareCategories.SPECIAL,
        string(
          abi.encodePacked(
            '<defs><linearGradient id="h112-a" x1="0" x2="0" y1="1" y2="0"><stop offset="0" stop-color="#fff"/><stop offset="1" stop-color="#4b4b4b"/></linearGradient><linearGradient id="h112-c" x1="0" x2="0" xlink:href="#h112-a" y1="0" y2="1"/><linearGradient id="h112-e" x1="0" x2="1" y1="0" y2="0"><stop offset="0" stop-color="#4b4b4b"/><stop offset=".5" stop-color="#fff"/><stop offset="1" stop-color="#4b4b4b"/></linearGradient><linearGradient id="h112-f" x1="0" x2="1" y1="0" y2="0"><stop offset="0" stop-color="gray"/><stop offset=".5" stop-color="#fff"/><stop offset="1" stop-color="gray"/></linearGradient><linearGradient id="h112-g" x1="0" x2="0" y1="1" y2="0"><stop offset="0" stop-color="gray"/><stop offset="1" stop-color="#fff"/></linearGradient><linearGradient id="h112-d" x1="0" x2="0" y1="1" y2="0"><stop offset="0" stop-color="#fff"/><stop offset=".5" stop-color="#4b4b4b"/><stop offset="1" stop-color="#fff"/></linearGradient><filter id="h112-b"><feDropShadow dx="0" dy="1" stdDeviation="0"/></filter></defs><g filter="url(#h112-b)"><path d="M153.75 91.65V146a43.75 43.75 0 0 1-87.5 0V91.65m87.5-7.13v-6.27h-87.5v6.05" fill="none" stroke="url(#h112-a)" stroke-width="2.5"/><path d="M145.94 78.27c2.91.65 4.22 2.13 4.43 3.36 1.45.43 2.27 1.4 4.08 5.71m-88.9 0c1.81-4.3 2.63-5.28 4.08-5.7.21-1.24 1.52-2.72 4.43-3.37h5.35s3.25 2.13 3.46 3.36a7.1 7.1 0 0 1 4.63 2.67 7.1 7.1 0 0 1 4.63-2.67c.21-1.23 3.46-3.36 3.46-3.36h6.32s3.25 2.13 3.46 3.36a7.1 7.1 0 0 1 4.63 2.68 7.1 7.1 0 0 1 4.63-2.68c.21-1.23 3.46-3.36 3.46-3.36h6.32s3.25 2.13 3.46 3.36a7.1 7.1 0 0 1 4.63 2.68 7.1 7.1 0 0 1 4.63-2.68c.21-1.23 3.46-3.36 3.46-3.36h5.35c2.91.65 4.22 2.13 4.43 3.36 1.45.43 2.27 1.4 4.08 5.72m-66.95.77v-3.81m22.5 3.81v-3.81m22.5 3.81v-3.81" fill="none" stroke="url(#h112-a)" stroke-width="2.5"/><path d="M87.5 88.12v4.07m22.5-4.07v4.08m22.5 0v-4.08m21.25 1.44s-1.1 4.68-3.38 5.31a6.67 6.67 0 0 1-13.24 0 7.1 7.1 0 0 1-4.63-2.67 7.1 7.1 0 0 1-4.63 2.67 6.67 6.67 0 0 1-13.24 0A7.1 7.1 0 0 1 110 92.2a7.1 7.1 0 0 1-4.63 2.67 6.67 6.67 0 0 1-13.24 0 7.1 7.1 0 0 1-4.63-2.67 7.1 7.1 0 0 1-4.63 2.67 6.67 6.67 0 0 1-13.24 0c-2.28-.63-3.38-5.31-3.38-5.31" fill="none" stroke="url(#h112-c)" stroke-width="2.5"/><path d="M119.58 99.78c.88 1.8 4.43 1.88 5.8 1.96 13.4 8.31 30.87 18.67 30.87 44.26" fill="none" stroke="url(#h112-c)" stroke-width="2.5"/><path d="M63.75 146c0-25.59 17.48-35.95 30.87-44.26 1.37-.08 4.92-.16 5.8-1.96" fill="none" stroke="url(#h112-c)" stroke-width="2.5"/><path d="M67.94 158.07A36.4 36.4 0 0 1 66.25 146c0-35.33 36.32-41.25 43.75-53.19 7.43 11.94 43.75 17.86 43.75 53.19a36.4 36.4 0 0 1-1.7 12.07" fill="none" stroke="url(#h112-a)" stroke-width="2.5"/><path d="m88.42 91.65-2.33 4.33c0 4.84-4.89 7.76-10.4 10.88-2.5 1.28-5 2.5-7.15 4.29l-3.63 10.55m66.68-30.05 2.33 4.33c0 4.84 4.89 7.77 10.4 10.88 2.5 1.28 5 2.5 7.15 4.29l3.63 10.55" fill="none" stroke="url(#h112-a)" stroke-width="2.5"/><path d="m155.3 133.73-1.73-9.3.2-2.93c0-7.36-4.39-9.55-10.51-13.29-7.51-4.59-11.46-8.5-11.46-13.02l.05-3.78M64.5 133.73l1.74-9.3-.2-2.93c0-7.36 4.39-9.55 10.5-13.29 7.52-4.59 11.47-8.5 11.47-13.02l-.05-3.78" fill="none" stroke="url(#h112-d)" stroke-width="2.5"/><path d="M76.25 98.25a4.38 4.38 0 0 1-4.38-4.38c.01-.47.07-.94.16-1.4-.461.093-.93.143-1.4.15-3.364.014-5.482-3.619-3.812-6.539l.012-.021a4.382 4.382 0 0 1 3.8-2.19c.47.01.94.07 1.4.16a7.659 7.659 0 0 1-.15-1.4c-.001-3.367 3.64-5.402 6.56-3.726 1.357.784 2.192 2.159 2.19 3.726a7.66 7.66 0 0 1-.16 1.4c.461-.093.93-.143 1.4-.15 3.367-.001 5.476 3.64 3.8 6.56a4.382 4.382 0 0 1-3.8 2.19 7.66 7.66 0 0 1-1.4-.16c.1.46.15.93.15 1.4a4.38 4.38 0 0 1-4.37 4.38Zm26.88-4.38a7.66 7.66 0 0 0-.16-1.4c.46.1.93.15 1.4.15 3.364.014 5.482-3.619 3.812-6.539l-.012-.021a4.382 4.382 0 0 0-3.8-2.19 7.66 7.66 0 0 0-1.4.16c.1-.46.15-.93.15-1.4.014-3.364-3.717-5.359-6.539-3.812-.007.004-2.409 1.24-2.211 3.812.036.469.07.94.16 1.4a7.659 7.659 0 0 0-1.4-.15c-3.367-.001-5.476 3.64-3.8 6.56a4.382 4.382 0 0 0 3.8 2.19 7.66 7.66 0 0 0 1.4-.16c-.093.461-.143.93-.15 1.4-.001 3.367 3.64 5.476 6.56 3.8a4.382 4.382 0 0 0 2.19-3.8Zm22.5 0a7.66 7.66 0 0 0-.16-1.4c.46.1.93.15 1.4.15 3.364.014 5.482-3.619 3.812-6.539l-.012-.021a4.382 4.382 0 0 0-3.8-2.19 7.66 7.66 0 0 0-1.4.16c.1-.46.15-.93.15-1.4.014-3.364-3.791-5.359-6.539-3.812-.007.004-2.434 1.19-2.211 3.812.04.468.07.94.16 1.4a7.659 7.659 0 0 0-1.4-.15c-3.367-.001-5.476 3.64-3.8 6.56a4.382 4.382 0 0 0 3.8 2.19 7.66 7.66 0 0 0 1.4-.16 7.66 7.66 0 0 0-.16 1.4c-.005 3.372 3.641 5.485 6.564 3.803l.006-.003a4.382 4.382 0 0 0 2.18-3.8h.01Zm22.5 0a7.66 7.66 0 0 0-.16-1.4c.46.1.93.15 1.4.15 3.364.014 5.482-3.619 3.812-6.539l-.012-.021a4.382 4.382 0 0 0-3.8-2.19 7.66 7.66 0 0 0-1.4.16c.1-.46.15-.93.16-1.4.019-3.364-3.734-5.315-6.534-3.821-.012.007-2.154 1.101-2.226 3.821-.012.47.07.94.16 1.4a7.659 7.659 0 0 0-1.4-.15c-3.367-.001-5.476 3.64-3.8 6.56a4.382 4.382 0 0 0 3.8 2.19 7.66 7.66 0 0 0 1.4-.16 7.66 7.66 0 0 0-.16 1.4c-.005 3.372 3.641 5.485 6.564 3.803l.006-.003a4.382 4.382 0 0 0 2.18-3.8h.01Z" fill="none" stroke="url(#h112-a)" stroke-width="2.5"/><path d="M151.23 149.42a69.44 69.44 0 0 1-1.18 18.52c-3.28 3.88-9.23 7.87-16.77 12.13a18.82 18.82 0 0 1-2.42.13" fill="none" stroke="url(#h112-e)" stroke-width="2.5"/><path d="M151.23 149.42a22.01 22.01 0 0 0-9.3-10.5s-9.9-5.1-9.8-16.64c0-11.58-9.34-22.46-22.11-22.46S87.9 110.71 87.9 122.28c.17 11.62-9.8 16.63-9.8 16.63h-.04a22.01 22.01 0 0 0-9.29 10.51 69.72 69.72 0 0 0 1.21 18.53c3.29 3.87 9.24 7.86 16.78 12.12a18.8 18.8 0 0 0 2.42.13 22.11 22.11 0 0 0 11.04-2.97 20.33 20.33 0 0 1 9.8-2.8c4.5 0 9.8 2.8 9.8 2.8a22.11 22.11 0 0 0 11.04 2.97 18.8 18.8 0 0 0 2.41-.13c7.55-4.26 13.5-8.25 16.78-12.12a69.44 69.44 0 0 0 1.18-18.53Z" fill="none" stroke="url(#h112-e)" stroke-width="2.5"/><path d="M110 161.68s-2.95 8.28-7.26 12.53l7.26-4.52 7.27 4.52c-5-4.17-7.27-12.53-7.27-12.53Z" fill="#4b4b4b"/><path d="m110 169.69-7.26 4.52a26.28 26.28 0 0 1 14.53 0Z" fill="#fff"/><path d="M89.2 125.63s2.96 8.28 7.27 12.53l-7.26-4.52-7.27 4.52c5-4.17 7.27-12.53 7.27-12.53Z" fill="#4b4b4b"/><path d="m89.2 133.64 7.27 4.52a27.91 27.91 0 0 0-14.53 0Z" fill="#fff"/><path d="M130.83 125.63s-2.96 8.28-7.27 12.53l7.27-4.52 7.27 4.52c-5-4.17-7.27-12.53-7.27-12.53Z" fill="#4b4b4b"/><path d="m130.83 133.64-7.27 4.52a25.17 25.17 0 0 1 14.54 0Z" fill="#fff"/><path d="M110 154.38s2.96-8.28 7.27-12.52l-7.27 4.52-7.26-4.52c5 4.16 7.26 12.52 7.26 12.52Z" fill="#fff"/><path d="m110 146.38 7.27-4.52a26.28 26.28 0 0 1-14.53 0Z" fill="#4b4b4b"/><path d="M118.73 140.06a11.68 11.68 0 0 0-6.55-19.15 11.7 11.7 0 0 0-2.26-.21c-10.31 0-12.34-14.78-4.47-13.84-.02-3.23 2.4-4.54 4.47-4.54 4.9 0 19.63 3.93 19.63 19.63a19.66 19.66 0 0 1-13.1 18.5" fill="none" stroke="url(#h112-a)" stroke-width="2.5"/><path d="M101.21 103.83a11.68 11.68 0 0 0 8.8 19.37c10.33 0 11.99 14.5 4.48 13.83-.16 3.32-2.4 4.54-4.47 4.54-4.9 0-19.62-3.92-19.62-19.62a19.66 19.66 0 0 1 13.09-18.51" fill="none" stroke="url(#h112-a)" stroke-width="2.5"/><path d="M77.88 174.7a11.68 11.68 0 0 0 12.36-17.31c-5.16-8.94 6.57-17.62 9.75-10.8 2.63-2.07 5.12-.2 6.16 1.6 2.45 4.25 6.41 18.96-7.18 26.81a19.66 19.66 0 0 1-22.57-2.08" fill="none" stroke="url(#h112-a)" stroke-width="2.5"/><path d="M110.78 156.53a11.68 11.68 0 0 0 21.17 2.06c5.16-8.94 18.54-3.12 14.22 3.04 3.12 1.24 2.73 4.34 1.7 6.14-2.46 4.25-13.22 15.03-26.81 7.18a19.66 19.66 0 0 1-9.48-20.59" fill="none" stroke="url(#h112-a)" stroke-width="2.5"/><path d="M100.49 141.41a11.68 11.68 0 0 0-12.37 17.3c5.16 8.94-6.56 17.63-9.74 10.8-2.63 2.07-5.13.2-6.17-1.6-2.45-4.25-6.41-18.96 7.19-26.81a19.66 19.66 0 0 1 22.57 2.08" fill="none" stroke="url(#h112-a)" stroke-width="2.5"/><path d="M150.91 159.47a11.68 11.68 0 0 0-21.17-2.05c-5.16 8.93-18.55 3.12-14.22-3.05-3.11-1.24-2.73-4.34-1.7-6.14 2.46-4.24 13.22-15.03 26.81-7.18a19.66 19.66 0 0 1 9.48 20.6" fill="none" stroke="url(#h112-a)" stroke-width="2.5"/><path d="M110 192.25A46.3 46.3 0 0 1 63.75 146V75.75h92.5V146A46.3 46.3 0 0 1 110 192.25Z" fill="none" stroke="url(#h112-c)" stroke-width="2.5"/><path d="m65.1 76.683 89.9.034 2.5-2.217h-95l2.6 2.183Z" fill="url(#h112-f)"/><path d="M149.33 82.49c.298-4.169-4.66-7.036-8.414-4.885a5.619 5.619 0 0 0-2.836 4.885c-4.328.007-7.03 4.69-4.87 8.44a5.63 5.63 0 0 0 4.87 2.81c-.001 4.332 4.686 7.042 8.44 4.88a5.63 5.63 0 0 0 2.8-4.88c4.326.01 7.041-4.667 4.886-8.419l-.006-.011a5.62 5.62 0 0 0-4.87-2.82Zm-39.38 5.63a5.62 5.62 0 0 1-5.62 5.62c.014 4.326-4.66 7.046-8.414 4.895a5.62 5.62 0 0 1-2.836-4.895c-4.326.002-7.033-4.68-4.871-8.427l.001-.003a5.62 5.62 0 0 1 4.87-2.82c.007-4.328 4.69-7.03 8.44-4.87a5.63 5.63 0 0 1 2.8 4.87 5.619 5.619 0 0 1 5.63 5.63Zm-22.5 0a5.62 5.62 0 0 1-5.62 5.62c.014 4.326-4.66 7.046-8.414 4.895a5.62 5.62 0 0 1-2.836-4.895c-4.326.002-7.033-4.68-4.871-8.427l.001-.003a5.62 5.62 0 0 1 4.87-2.82c.007-4.328 4.69-7.03 8.44-4.87a5.63 5.63 0 0 1 2.8 4.87 5.619 5.619 0 0 1 5.63 5.63Zm45 0a5.62 5.62 0 0 1-5.62 5.62c.014 4.326-4.66 7.046-8.414 4.895a5.62 5.62 0 0 1-2.836-4.895c-4.326.002-7.033-4.68-4.871-8.427l.001-.003a5.62 5.62 0 0 1 4.87-2.82c.007-4.328 4.69-7.03 8.44-4.87a5.63 5.63 0 0 1 2.8 4.87 5.619 5.619 0 0 1 5.63 5.63Zm-32.6 87.85a20.73 20.73 0 0 0 9.42-12.5c.4-1.52.65-3.08.7-4.66a20.889 20.889 0 0 0 10.08 17.14 19.74 19.74 0 0 0-20.2.02Zm-20.9-36.13a19.73 19.73 0 0 0 10.15-17.58v-.01a20.88 20.88 0 0 0 9.94 17.47 20.798 20.798 0 0 0-20.1.13l.01-.01Zm62.03 0a20.802 20.802 0 0 0-20.08-.12 20.88 20.88 0 0 0 9.94-17.45 20.04 20.04 0 0 0 10.14 17.56v.01Zm-41.43 36.31c-13.91 8.03-31.3-2-31.3-18.08s17.39-26.1 31.3-18.07a20.874 20.874 0 0 1 7.64 7.64c5.764 9.982 2.343 22.747-7.64 28.51Zm13.2-28.51c-8.03 13.91 2.01 31.3 18.08 31.3s26.1-17.39 18.07-31.3a20.874 20.874 0 0 0-7.64-7.64c-9.98-5.757-22.738-2.337-28.5 7.64h-.01Zm-2.78-4.82c16.07 0 26.11-17.4 18.08-31.31-8.03-13.92-28.12-13.92-36.15 0a20.879 20.879 0 0 0-2.8 10.44c0 11.526 9.344 20.87 20.87 20.87ZM155 122c0-16.27-22.54-12.5-22.54-29.19v-4.56m-45 0v4.56c0 16.69-22.42 12.92-22.42 29.19m44.92 69c-24.83-.039-44.943-20.17-44.96-45l.1-69.2H155l-.1 69.2c-.017 24.826-20.124 44.956-44.95 45h.01Zm10.46-58.62c0 3.57-1.8 6.09-4.04 6.02 0 0-1.1 4.42-6.4 4.42 8.03 0 13.06-8.7 9.04-15.66a10.439 10.439 0 0 0-9.04-5.21c-8.035-.083-12.967-8.832-8.88-15.75a10.44 10.44 0 0 1 8.88-5.13m-2.78 46.5c-4.057-6.935-14.1-6.879-18.08.1a10.438 10.438 0 0 0 0 10.34c3.969 6.981-1.1 15.642-9.13 15.6a10.432 10.432 0 0 1-8.95-5.16m41.72-20.81c-4.003 6.936 1.004 15.604 9.012 15.603a10.404 10.404 0 0 0 9.008-5.203c4.111-6.941 14.193-6.83 18.15.2a10.478 10.478 0 0 1 0 10.3m-49.3-57.03c0-3.56 1.7-5.62 3.96-6.01 0 0 .54-4.43 6.4-4.43m-17.05 42.68c3.09-1.78 6.17-1.49 7.23.5 0 0 4.1-1.74 7.03 3.32m-21.9 24.7c-3.08 1.78-6.17 1.02-7.23-.5 0 0-4.1 1.74-7.02-3.32m45.48-6.59c-3.09-1.78-4.38-4.6-3.19-6.5 0 0-3.5-2.66-.58-7.72m32.28 6.58c3.09 1.79 4.38 4.6 3.19 6.51 0 0 3.62 2.75.7 7.81m-44.4-73.12 1.7-1.43m9.17 1.43-1.7-1.43m-3.74-5.3c0 13.34 44.96 17.02 44.96 57.31M65 146c0-40.3 44.85-43.68 44.95-57.31" fill="none" stroke="url(#h112-g)" stroke-width="1.5"/></g>'
          )
        )
      );
  }

  function hardware_113() public pure returns (HardwareData memory) {
    return
      HardwareData(
        "Starfield",
        HardwareCategories.SPECIAL,
        string(
          abi.encodePacked(
            '<defs><linearGradient gradientUnits="userSpaceOnUse" id="h113-a" x1="-.16" x2="2.82" y1="-1.28" y2="5.42"><stop offset="0" stop-color="#4b4b4b"/><stop offset="1" stop-color="#fff"/></linearGradient><linearGradient gradientTransform="matrix(1 0 0 -1 0 16389.97)" id="h113-d" x1=".87" x2=".87" xlink:href="#h113-a" y1="16384" y2="16389.96"/><linearGradient gradientTransform="matrix(0 -1 -1 0 8170.06 8159.54)" id="h113-e" x1="8151.68" x2="8154.66" xlink:href="#h113-a" y1="8156.84" y2="8163.54"/><linearGradient gradientTransform="rotate(-90 -33.81 8193.35)" id="h113-h" x1="8152.71" x2="8152.71" xlink:href="#h113-a" y1="8233.12" y2="8239.09"/><linearGradient id="h113-b" x1="1.2" x2="2.8" xlink:href="#h113-a" y1="-.61" y2="5.28"/><linearGradient id="h113-c" x1=".94" x2="1.61" xlink:href="#h113-a" y1="5.32" y2="1.3"/><symbol id="h113-f" viewBox="0 0 3.62 5.97"><path d="m1.89 0-.52 3.69L1.88 6l1.74-1.77Z" fill="url(#h113-b)"/><path d="M1.88 0 0 4.6 1.88 6Z" fill="url(#h113-c)"/></symbol><symbol id="h113-g" viewBox="0 0 3.47 5.97"><path d="m1.74 0-.52 3.69L1.73 6l1.74-1.77Z" fill="url(#h113-a)"/><path d="M1.73 0 0 4.23 1.73 6Z" fill="url(#h113-d)"/></symbol><symbol id="h113-i" viewBox="0 0 11.93 13.21"><path d="m0 6 4.23 3.33L6 13.19l1.7-3.86L11.93 6Z"/><path d="m11.93 6-3.69.51L6 6l1.26-1.95Z" fill="url(#h113-e)"/><use height="5.97" transform="translate(4.08)" width="3.62" xlink:href="#h113-f"/><use height="5.97" transform="rotate(-90 3.85 3.85)" width="3.47" xlink:href="#h113-g"/><use height="5.97" transform="rotate(180 3.92 5.97)" width="3.62" xlink:href="#h113-f"/><path d="M11.93 6 7.7 7.7 6 6Z" fill="url(#h113-h)"/></symbol></defs><use height="13.21" transform="translate(66.53 81)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(91.53 81)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(116.53 81)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(141.53 81)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(79.03 96)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(104.03 96)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(129.03 96)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(79.03 126)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(104.03 126)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(129.03 126)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(79.03 156)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(104.03 156)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(129.03 156)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(66.53 111)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(91.53 111)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(116.53 111)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(141.53 111)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(66.53 141)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(91.53 141)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(116.53 141)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(141.53 141)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(91.53 171)" width="11.93" xlink:href="#h113-i"/><use height="13.21" transform="translate(116.53 171)" width="11.93" xlink:href="#h113-i"/>'
          )
        )
      );
  }
}
