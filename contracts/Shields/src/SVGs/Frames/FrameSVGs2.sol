// SPDX-License-Identifier: The Unlicense

pragma solidity ^0.8.13;

import "../../interfaces/IFrameSVGs.sol";

/// @dev Experimenting with a contract that holds huuuge svg strings
contract FrameSVGs2 is IFrameSVGs {
  function frame_4() public pure returns (FrameData memory) {
    return
      FrameData(
        "Floriated",
        1 ether,
        string(
          abi.encodePacked(
            '<defs><linearGradient id="fr3-a" x1="0" x2="0" y1="0" y2="1"><stop offset="0" stop-color="gray"/><stop offset="1" stop-color="#fff"/></linearGradient><linearGradient gradientUnits="userSpaceOnUse" id="fr3-b" x1="48.87" x2="80.92" y1="20.8" y2="20.8"><stop offset="0" stop-color="#fff"/><stop offset=".5" stop-color="gray"/><stop offset="1" stop-color="#fff"/></linearGradient><linearGradient id="fr3-c" x1="0" x2="0" xlink:href="#fr3-a" y1="1" y2="0"/><linearGradient id="fr3-g" x1="110" x2="110" xlink:href="#fr3-b" y1="199.5" y2="69.76"/><linearGradient gradientUnits="userSpaceOnUse" id="fr3-h" x1="57.5" x2="162.5" y1="70.76" y2="70.76"><stop offset="0" stop-color="gray"/><stop offset=".5" stop-color="#fff"/><stop offset="1" stop-color="gray"/></linearGradient><symbol id="fr3-d" viewBox="0 0 92.61 200.66"><path d="M53.82 31.86v74a52.56 52.56 0 0 1-52.5 52.5L0 176l1.32 24.66c1.49-4.58 7.4-4.68 7.4-10.42v-2s-6.04-3.1-3.15-5.99 3.84 3.14 8 3.14c5.74 0 5.83-5.9 10.41-7.39v-2H2.75l2.13-5.49c.63-2.7 3.61-5.98 9.3-7.48 8.54-2.15 13.72 1.35 14.32 4.77l-2.48 2.06v2l10.35 4.23 2.59-10.88v-2c-3.33.03-5.87-1.17-6.26-4.03a15.14 15.14 0 0 1 5.7-9.07c7.33-5.59 11.76-3.8 12.66-1.87-.96 1.74-7.12 3.54-7.12 3.54-3.18 5.73.88 10.63 0 12.38v2c3.88-2.86 8.73.5 12.08-4.17 1.75-2.14-.6-8.32 2.1-8.32 4.09 0 1.29 4.79 4.67 7.2 4.67 3.35 8.18-1.4 12.77.07v-2s-13.68-4.76-12.36-13.65c.9-1.82 4.52-.84 7.08-3.2 2.95-2.72-.33-8.81.06-14.78-3.88 2.87-15.8 17.38-15.8 17.38a107.92 107.92 0 0 1-1.58-11.06c.26-6.3 2.96-13.94 8.49-13.94a6.83 6.83 0 0 1 6.5 4.62l9.41-6.08v-2s-19.91.82-19.91-18.66c.3-7.66 6.56-12.2 8.76-9.5.06.08-3.65 5.64-3.65 5.64v2c0 5.75 5.9 5.84 7.39 10.43 1.48-4.59 7.38-4.68 7.38-10.43v-2l-3.9-5.58c2.55-2.55 4.6 2.73 8.75 2.73 5.75 0 5.84-5.9 10.42-7.38v-2s-17.8.97-18.59-4.48c.95-1.43 3.32-3.02 3.32-5.76v-2H62.56v2c0 2.66 2.43 4.29 3.45 5.7-.25 1.31-9.21 5.56-9.21-14.06.42-10.74 9.55-13.46 13.15-7.64l8.5-7.27v-2S59.93 48 59.93 35.34c.37-4.38 2.92-9.81 5.3-9.81 1.7 0 2.06.86 2.12 2.08l.02.34c.02 1.67-.32 3.85 1.28 5.45 4.06 4.06 8.3-.05 12.6 2.14v-2l-9.86-15.02c.83-2.4 5.07.21 7.71-2.43a5.96 5.96 0 0 0 1.83-5.66 17.69 17.69 0 0 1 .32-6.93v-2L65.22 17.53 49.2 1.5v2a11.66 11.66 0 0 1 .32 6.93 5.92 5.92 0 0 0 1.82 5.66c2.6 2.6 6.76.1 7.68 2.32 0 8.05-18.92 8.3-18.92-.29a6.3 6.3 0 0 1 3.23-3.88v-2H28.77v2a5.75 5.75 0 0 1 3.13 3.71c-2.35 10.8-22.35 10.8-27 1.08 3.17-3.38 4.5 2.6 8.66 2.6 5.75 0 5.84-5.9 10.43-7.39v-2c-11.16 0-16.88-.82-18.83-4.74C6.12 6.08 8.7 4.73 8.7 2V0H0l1.32 31.86Z"/></symbol><symbol id="fr3-e" viewBox="0 0 92.29 209.08"><path d="m35.72 14.17-1.09 9.68L43 22.66l-7.28-8.49z" fill="url(#fr3-a)"/><path d="M80.92 11.92c-4.29 2.2-8.53-1.92-12.6 2.14-2.93 2.94.66 7.87-3.42 7.87s-.5-4.93-3.43-7.87c-4.06-4.06-8.3.05-12.6-2.14L64.9 29.69Z" fill="url(#fr3-b)"/><path d="m28.45 22.66 7.27 1.04v-9.53l-7.27 8.49z" fill="url(#fr3-a)"/><path d="M69.63 114.56c1.48-4.58 7.39-4.67 7.39-10.42 0-4.15-5.7-5.44-3.14-7.99s3.83 3.14 7.99 3.14c5.74 0 5.83-5.9 10.42-7.39l-23.84-1.19Z" fill="url(#fr3-a)"/><path d="M81.87 84.52c-4.16 0-5.67 5.46-8 3.13s3.15-3.83 3.15-7.98c0-5.75-5.91-5.84-7.4-10.43L68.26 91.9H92.3c-4.59-1.48-4.68-7.38-10.42-7.38Z" fill="url(#fr3-a)"/><path d="m69.63 63.67 8.49-7.28-9.38-1 .89 8.28z" fill="url(#fr3-a)"/><path d="m78.12 56.39-8.49-7.28-1.08 7.28h9.57z" fill="url(#fr3-a)"/><path d="M43.62 174.58c3.88-2.86 8.73.5 12.08-4.17 2.42-3.37-1.93-7.65 2.1-8.32s1.29 4.79 4.67 7.2c4.66 3.35 8.18-1.4 12.77.07l-18.62-14.73Z" fill="url(#fr3-a)"/><path d="m67.62 132.74 9.43-6.08-9.14-2.04-.29 8.12z" fill="url(#fr3-a)"/><path d="m68.46 125.48 8.59 1.18-7.42-8.37-1.17 7.19z" fill="url(#fr3-a)"/><path d="M75.24 169.36c-2.86-3.88.5-8.73-4.17-12.08-3.37-2.41-7.65 1.93-8.32-2.1s4.79-1.29 7.2-4.66c3.35-4.67-1.4-8.19.07-12.78l-14.17 17.72Z" fill="url(#fr3-a)"/><path d="M1 209.08c1.48-4.58 7.39-4.68 7.39-10.42 0-4.15-6.03-5.1-3.14-7.99s3.83 3.14 7.99 3.14c5.74 0 5.84-5.9 10.42-7.39L0 185.36Z" fill="url(#fr3-a)"/><path d="m25.7 180.28 10.35 4.24-3.67-8.3-6.68 4.06z" fill="url(#fr3-a)"/><path d="m36.05 184.52 2.59-10.89-6.71 2.86 4.12 8.03z" fill="url(#fr3-a)"/><path d="m1 169.29-1 17.13h23.66c-4.59-1.48-4.68-7.39-10.42-7.39-4.16 0-5.1 6.03-7.99 3.14-2.34-2.34.17-8.5 8.6-10.72 12.54-3.16 14.97 4.13 11.85 8.83l7.23-3.72-7.73-13.15A52.67 52.67 0 0 1 1 169.29Z" fill="url(#fr3-a)"/><path d="m57.45 155.28-13.34-8.24a53.35 53.35 0 0 1-18.9 16.37l6.96 13.55 6.47-3.33c-6.92.06-8.51-9.06-.57-15.1s12.48-3.45 12.82-1.38c.67 4.03-4.78 1.29-7.2 4.66-3.34 4.67 1.4 8.19-.06 12.78Z" fill="url(#fr3-a)"/><path d="M57.94 141.91c-2.42 3.38 1.93 7.66-2.1 8.32-5.38.9-4.3-22.11 5.3-22.11a6.83 6.83 0 0 1 6.49 4.62l1.24-8.97-15.37-.34a52.7 52.7 0 0 1-9.38 23.61l12.7 9.12 13.2-18.42c-3.88 2.87-8.73-.5-12.08 4.17Z" fill="url(#fr3-a)"/><path d="M69.63 118.28c-3.49 5.38-12.53 2.87-12.53-11.66 0-8.05 6.02-12.72 8.28-10.47s-3.14 3.84-3.14 8c0 5.74 5.9 5.83 7.39 10.41V90.72L53.99 91.9v24.38a53.23 53.23 0 0 1-.5 7.14l15.14 2.06Z" fill="url(#fr3-a)"/><path d="M69.63 63.66v-8.55l-15.64 1.28V91.9h15.64V69.24c-1.49 4.59-7.4 4.68-7.4 10.43 0 4.15 5.93 5.78 3.15 7.98S57 82.53 57 72.1c0-11.42 8.93-14.4 12.63-8.43Z" fill="url(#fr3-a)"/><path d="M64.9 25.88 54 38.27v18.1h15.63V49.1c-2.65 5.08-10.08 4.69-10.08-4.31 0-4.5 2.78-10.85 5.35-10.85 4.08 0 .5 4.93 3.43 7.87 4.06 4.06 8.3-.05 12.6 2.14Z" fill="url(#fr3-a)"/><path d="M80.92 43.97c-2.2-4.3 1.92-8.54-2.14-12.6-2.94-2.94-7.87.66-7.87-3.43s4.93-.5 7.87-3.43c4.06-4.06-.05-8.3 2.14-12.6L64.9 27.96Z" fill="url(#fr3-a)"/><path d="M48.87 11.92c2.2 4.29-1.91 8.53 2.15 12.6 2.94 2.93 7.87-.66 7.87 3.42 0 2.8-5.79 6.03-10.41 6.03-7.97 0-12.18-7.36-5.48-11.3h-8.7l1.42 15.62H54l10.9-10.34Z" fill="url(#fr3-a)"/><path d="M35.72 38.29V22.66h-7.27c6.87 3.7 2.5 12.63-10.03 12.63-10.54 0-15.51-6.04-13.17-8.38 2.89-2.89 3.84 3.14 7.99 3.14 5.74 0 5.84-5.9 10.42-7.39L0 21.14l1 17.15Z" fill="url(#fr3-a)"/><path d="M23.66 22.66c-4.59-1.48-4.68-7.39-10.42-7.39-4.16 0-5.1 6.03-7.99 3.14s3.14-3.83 3.14-7.99C8.39 4.68 2.49 4.6 1 0L0 22.66Z" fill="url(#fr3-a)"/></symbol><symbol id="fr3-f" viewBox="0 0 88.27 200.06"><path d="M82.35 82.5c-2.2 0-3.3 3.93-6.5 3.93a5.08 5.08 0 0 1-4.77-4.82C71.1 79.46 75 78.2 75 75.16s-4.07-4.4-4.89-5.92c-1.41 2-4.89 3.05-4.89 5.92s3.9 3.64 3.93 6.45a4.55 4.55 0 0 1-4.63 4.42C58.8 86.03 55 77 55 67.6c0-16.04 12.63-14.56 15.12-11.72l4.66-3.99-4.66-3.79c-2.67 3.21-12.57 4.3-12.57-7.8 0-4.7 2.98-13.35 7.84-13.35 6.39 0 3.7 7.05 5.2 8.6 2.01 2.09 3 .76 7.64.73.01-1.4 1.57-5.64-.72-7.64-2.9-2.53-8.6.3-8.6-5.2 0-5.9 7.1-3.58 8.6-5.2 2.06-2.22.52-4.56.72-7.64-2.67.21-5.5-1.25-7.64.73s.33 5.17-1.79 7.34c-1.97 2-5.51 1.32-6.8 0-2.24-2.27-.27-5.8-1.8-7.34-2.13-2.15-4.16-.69-7.64-.73.37 2.1-1.66 5.24.72 7.64 1.83 1.84 8.6-.62 8.6 5.2 0 4.95-7.7 8.52-12.9 8.52-12.32 0-12.53-11.36-9.08-13.8l-3.68-4.65-3.66 4.65c4.24 2.92 2.25 15.13-13.64 15.13-16.5 0-17.42-10.74-14.94-12.64 5.02-3.87 5.79 2.4 9.76 2.4s4.02-3.42 5.9-4.89c-3.2-3.26-3.24-4.89-5.9-4.89-2.28 0-2.93 3.93-6.5 3.93a4.86 4.86 0 0 1-4.78-4.82c.02-2.15 3.92-3.81 3.92-6.46S2.91 1.98 1.5 0L0 18.15l1.49 17.63h51.5v76c0 28.95-22.56 51.5-51.5 51.5L0 181.9l1.49 18.15c1.94-2.48 4.88-2.7 4.88-5.9 0-2.64-6.75-5.1-2.4-9.77 4.38-4.7 7.77 2.41 9.75 2.41 2.79 0 3.65-2.98 5.92-4.89-2.4-1.9-3.25-4.89-5.92-4.89-2.89 0-5.81 5.92-9.75 2.41-2.1-1.87-4-11.28 9.76-14.91 3.85-1.02 18.36-2.67 15.51 9.69l5.54 2.38 1.09-5.8c-3.95-.73-10.14-9.78 1.17-18.76 8.73-6.93 16.02-4.54 16.8.2 1.01 6.15-5.4 3.93-7.64 6.53s.43 5.1.53 7.65c2.32-.6 6 .6 7.42-1.96 1.48-2.67-2.67-8.07 3.73-9.33 5.97-1.18 3.95 5.9 6.53 7.64 2.19 1.48 5.64-.5 7.65-.53-.57-3.64.5-5.29-1.96-7.42s-8.4 1.87-9.33-3.73c-1-6.03 5.36-3.93 7.64-6.53 1.86-2.13.03-4.41-.53-7.65-3.64.57-5.8 0-7.42 1.96-1.92 2.32 2.7 8.27-3.73 9.33-.25.05-2.88.63-4.67-2.46-2.44-4.23-1.81-13.85 1.47-19.3 5.35-8.92 13.03-4.26 15.06-1.67l5.14-3.13-4.1-4.3c-2.11 1.53-7.1 3.6-11.47-2.94-2-3-3.07-7.25-3.07-12.27 0-7.7 4.51-13.72 9.4-13.72a4.75 4.75 0 0 1 4.66 4.78c0 2.82-3.92 3.77-3.92 6.46s3.02 3.63 4.89 5.91c3.25-3.21 4.88-3.58 4.88-5.92s-3.92-3.14-3.92-6.45a5.33 5.33 0 0 1 4.78-4.82c3.14 0 4.3 3.92 6.5 3.92 3.55 0 4.46-3.75 5.9-4.88-1.44-1.14-2.35-4.9-5.9-4.9Z" fill="url(#fr3-c)"/></symbol></defs><use height="200.66" transform="translate(108.68 41.14)" width="92.61" xlink:href="#fr3-d"/><use height="200.66" transform="matrix(-1 0 0 1 111.32 41.14)" width="92.61" xlink:href="#fr3-d"/><path d="M0 0h220v264H0z" fill="none"/><use height="209.08" transform="translate(109 30.72)" width="92.29" xlink:href="#fr3-e"/><use height="209.08" transform="matrix(-1 0 0 1 111 30.72)" width="92.29" xlink:href="#fr3-e"/><use height="200.06" transform="translate(108.51 35.23)" width="88.27" xlink:href="#fr3-f"/><use height="200.06" transform="matrix(-1 0 0 1 111.49 35.23)" width="88.27" xlink:href="#fr3-f"/><path d="M160 72v75a50 50 0 0 1-100 0V72Z" fill="none"/><path d="M161.25,69.5082V147a51.25,51.25,0,0,1-102.5,0V69.5082" fill="none" stroke="url(#fr3-g)" stroke-width="2.5"/><path d="M160 72.01H60l-2.5-2.5h105l-2.5 2.5z" fill="url(#fr3-h)"/>'
          )
        )
      );
  }

  function frame_5() public pure returns (FrameData memory) {
    return
      FrameData(
        "Everlasting",
        2 ether,
        string(
          abi.encodePacked(
            '<defs><linearGradient id="fr4-a" x1="0" x2="1" y1="0" y2="0"><stop offset="0" stop-color="#fff"/><stop offset="1" stop-color="#4b4b4b"/></linearGradient><linearGradient id="fr4-b" x1="0" x2="1" xlink:href="#fr4-a" y1="0" y2="2"/><linearGradient id="fr4-c" x1="0" x2="0" xlink:href="#fr4-a" y1=".75" y2="0"/><linearGradient id="fr4-d" x1="0" x2="0" xlink:href="#fr4-a" y1="0" y2="1.5"/><linearGradient id="fr4-e" x1="0" x2="0" xlink:href="#fr4-a" y1="1" y2="0"/><linearGradient id="fr4-g" x1="0" x2="0" xlink:href="#fr4-a" y1="1" y2="0"/><linearGradient id="fr4-f" x1=".35" x2=".6" xlink:href="#fr4-a" y1=".2" y2=".7"/><linearGradient id="fr4-h" x1="1" x2="0" xlink:href="#fr4-a" y1="0" y2="0"/><linearGradient id="fr4-j" x1="0" x2="0" xlink:href="#fr4-a" y1="0" y2="2"/><linearGradient id="fr4-i" x1="0" x2="1" y1="0" y2="0"><stop offset="0"/><stop offset=".5" stop-color="#fff"/><stop offset="1"/></linearGradient><linearGradient gradientUnits="userSpaceOnUse" id="fr4-k" x1="110" x2="110" y1="221.44" y2="49.83"><stop offset="0" stop-color="#fff"/><stop offset=".5" stop-color="gray"/><stop offset="1" stop-color="#fff"/></linearGradient><linearGradient gradientUnits="userSpaceOnUse" id="fr4-m" x1="110" x2="110" y1="199.01" y2="69.96"><stop offset="0" stop-color="#fff"/><stop offset=".5" stop-color="#4b4b4b"/><stop offset="1" stop-color="#fff"/></linearGradient><linearGradient gradientUnits="userSpaceOnUse" id="fr4-n" x1="58" x2="162" y1="71.01" y2="71.01"><stop offset="0" stop-color="#4b4b4b"/><stop offset=".5" stop-color="#fff"/><stop offset="1" stop-color="#4b4b4b"/></linearGradient><symbol id="fr4-l" viewBox="0 0 100.04 242.01"><path d="m75.33 51.44-3.59 10.27-12.5 7.14.78-3.93Zm-5.38 16.01-11.83 8.58-.6 5.52 9.65-3.9ZM66.31 81.3l-9.18 5.46-.25 5.06 7.43-.54Zm-2.4 12.44-7.16 3.68-.01 5.63 5.93.43Zm-1.4 11.57-5.7 2.56.2 6.21 5.02.8Zm-.48 11.12-4.8 2.63.28 5.01 4.85 1.86Zm.47 11.1-4.66 1.58.26 5.36 5.7 2.63Zm1.7 11.6-6.06.53-.2 5.02 8.87 4.38Zm-6.85 11.1-.74 4.23 16.62 9.38-5.27-11.49Zm-2.3 9.96-1.7 4.26 26.48 17.94 6.08-1.1Zm7.43-105.6 16.74-13.02 4.28-9.8-20.02 18.98Z" fill="url(#fr4-a)"/><path d="m68.19 185.5-7.45 2.64-13.65-14.18 2.24-2.75ZM41.83 179l-3.92 2.98 8.23 12.95 7.6-3.82Zm-9.1 6.4-4.6 2.81 5.74 14.47 7.2-4.8Zm-9.55 5.76-5.02 3.09L22.7 212l6.48-5.72Zm-10.29 6.58-3.1 2.22 1.74 24.73 5.36-6.63Z" fill="url(#fr4-b)"/><path d="m13.68 15.3 5.17 2.96L11.9 42.3 9.33 42Zm9.35 28.96 10.5-21.43-5.55-1.18-7.5 22.17Zm7.9 1.34 3.35.57 14.31-22.78-5.64.2Zm10.19 1.73 4.23.72 20.97-28.33-5.15 1.53Zm15.48 2.64 36.88-38.29L100.04 0 51.78 49.15Z" fill="url(#fr4-c)"/><path d="m11.52 42.26 7.33-24-3.48 24.42-3.98 14.84ZM0 40.34 1.26 2.57l3.02 38.22-1.06 16.73Zm20.48 17.18 5.77-13 7.27-21.7L22.65 44.2Zm9.7 0 6.81-11.16 11.6-22.97-14.82 22.7Zm10.25 0 7.2-9.36 18.4-28-21.31 27.79Zm9.56 0 8.7-7.47 34.79-38.37-37.6 38.16Z" fill="url(#fr4-d)"/><path d="M49.37 48.46 100.04 0 52.5 49.27l-9.56 8.25Zm-16.81 9.06 9.2-10.08 19.41-26.2-22.42 25.41Zm-9.8 0 8.67-11.83 11.52-22.1-14.92 21.24Zm-9.2 0 7.3-13.63 7.12-22.24L17.2 42.99Zm-8.37 0L9.7 42.03l3.97-26.73-7.42 25.83Z" fill="url(#fr4-e)"/><path d="m44.46 165.47 6.77 2.6 16.96 17.43-19.2-13.88Zm-.57 11.43-5.54-3.54 2.89 6.1 12.5 11.65Zm-13.26 3.28 4.09 3.67 6.34 14.02-9.02-12.05Zm-8.7 5.17 3.23 4.35 4.02 16.58-6.75-14.66Zm-9.86 3.54 3.53 6.75 1.29 22.42-4.47-19.99Zm-6.72 14.26L3.47 190.3.02 209.95l1.2 32.07Z" fill="url(#fr4-f)"/><path d="m40.69 170.7 6.74 2.85 13.31 14.6-15.8-12.25Zm-7.18 7.24 1.98 5.4 10.65 11.59-7.64-13.4Zm-8.4 5.78 3.71 4.07 5.05 14.89-8.3-13.22Zm-10.08 4.34 3.89 5.73L22.7 212l-6.56-16.72Zm-8.13 1.87L7 201.8l4.52 22.88-1.28-25.06Z" fill="url(#fr4-g)"/><path d="m53.14 57.52 7.26-7.18 23.1-18.58-20.17 19.56Zm6.76 7.99 15.43-14.07-14.57 9.84L53 67.8Zm-1.87 11.35 11.92-9.4-11.54 6.26L53 78.06ZM57.1 87.5l9.22-6.22-9.08 3.68-4.25 3.46Zm-4.13 10.9 3.82-2.8 7.12-1.88-7.15 4.52Zm-.01 10.08 3.84-2.52 5.72-.67-5.67 3.5Zm-.01 10.59 4.18-2.83 4.9.17-4.75 3.39Zm-.01 9.1 4.75-1.6 4.82.93-4.62 2.4Zm-.03 8.95 5.24-.19 6.06 2.18-6.1 1.28Zm-.98 9.68 5.79.07 10.25 5.46-10.72-1.49Zm3.68 11.25-6.07-2.72 5.26 5.48 31.1 20.49Z" fill="url(#fr4-a)"/><path d="M79.22 41.56 61.4 58.62 53 64.24 62.64 54ZM53 73.62l5.62-1.3 13.12-10.6-12.38 6.54Zm4.29 10.55-4.3.03 4.62-3.48 9.56-3.06Zm-.5 10.9 7.52-3.8-7.4-.22-3.94 2.5Zm0 10.47 5.88-2.07-5.93-1.27-3.78 1.73Zm.3 10.3 4.94-.97-5.05-1.73-4.04 1.43Zm.56 10.27 4.71-.2-4.9-2.6-4.53.82Zm.49 10.32 5.66.66-5.74-3.43-5.14.54Zm-.4 10.12 9.07 2.5-8.84-5.13-5.59.1Zm-1.76 10.16 17.25 7.12-16.51-10.02-6.3-1.04Zm23.85 25.67-27.8-15.69-5.52-4.69 7.09 1.8Z" fill="url(#fr4-h)"/></symbol></defs><path d="m166.69 170.54-.95-1.74 18.58 5.52-17.77-15.6 11.33.81L168 148.7l6.88-1.12-7.88-9.14 6.5-2-6.07-8.13 5.74-2.92-6.47-6.95 7.11-4.44-7.8-5.62 8.89-6.38-9-3.65 12.39-10.2-11.61-.88 16.15-15.07-13.25 2L190.3 52l-21.69 12.32 35.95-42.15-45.86 39.48 18.7-31.44-30.33 32.63 12.6-29L137.34 60l7.27-26.71-17.15 23.87 2.48-28.42L117.14 56l-4.8-40.89h-4.69L102.86 56l-12.8-27.26 2.49 28.42-17.16-23.85L82.67 60 60.31 33.87l12.6 29-30.34-32.66 18.7 31.44-45.84-39.48 35.94 42.15L29.68 52l20.73 22.2-13.24-2 16.18 15.07-11.6.88 12.39 10.2-9 3.65 8.86 6.34-7.77 5.66 7.12 4.44-6.48 6.95 5.75 2.92-6.07 8.13 6.5 2-7.93 9.14L52 148.7l-9.89 10.83 11.34-.81-17.77 15.6 18.58-5.52-.95 1.74-24.23 22.33 29.06-14-10 19.79 17.57-11.09-3 17.87 12.39-10.87v18.6l9.26-12 1.91 21.29 7.42-14.8 3.74 27.48 6.88-23.64h11.42l6.88 23.64 3.74-27.48 7.42 14.8 1.91-21.29 9.26 12v-18.6l12.32 10.84-3-17.87 17.57 11.09-10-19.79 29.06 14ZM161 147.01a51.06 51.06 0 0 1-51 51c-28.12 0-51-22.88-51-52V73h102Z"/><path d="m211.13 10.49-49.85 48.6-3.4-.58 19.53-28.3-5.16 1.52-21.58 25.55-3.42-.58 12.43-22.83-5.64.22L140 55.46l-3.48-.59 8.12-21.56-5.55-1.17-9.89 21.49-3.62-.63 4.36-24.27-5.18-2.95-6.48 26-3.85-.65-2.09-38.06h-4.68l-2.09 38.06-3.85.65-6.48-26-5.18 2.95L94.42 53l-3.59.62-9.89-21.48-5.55 1.17 8.12 21.56-3.51.59-14-21.37-5.64-.22L72.75 56.7l-3.42.58-21.58-25.55-5.16-1.52 19.53 28.3-3.4.58-49.85-48.6 6.56 11.68L51 60.4l-3.3.6-22.28-18.76L29.69 52l17.53 15.8 1.23 5.2-14.86-11.07 3.58 10.27 13 10 .41 2.7L39 77.94l2.79 10.21 9.85 6.12.11 1.56-9.1-4.06 2 10 7.51 3.55v1L45 104.21l1.24 9.79 5.9 1.86v.85l-5.72-.88.48 9.56 4.94.78v.81h-4.9l-.34 9.49h4.72l-.05.92-4.8.71-1.3 9.58 5.66-.9v1l-6.06 1.94-2.61 9.92 9-2.65.06.64-10.22 5.2-5.28 11.49 17.07-7.77.74 2.64L23 191.78l6.08 1.09 27.42-16.35 1.57 2.7L40.72 196l7.45 2.64 15.3-12.72 2.06 2-10.36 13.67 7.6 3.82 10.29-11.82 1.5 1-6.71 13.79 7.2 4.81 8.1-13.34.8.48-4.21 16.46 6.48 5.72 6.3-16.89 1 .69L92 228.55l5.35 6.62 3.73-23.51 3.24 2.61 3.34 38.23h4.62l3.34-38.23 3.24-2.61 3.73 23.51 5.35-6.62-1.54-22.26 1-.69 6.3 16.89 6.48-5.72-4.21-16.46.8-.48 8.1 13.34 7.2-4.81-6.71-13.79 1.5-1 10.29 11.82 7.6-3.82-10.36-13.73 2.06-2 15.3 12.72 7.45-2.64-17.35-16.77 1.57-2.7 27.42 16.35 6.08-1.09-30.49-22.59.74-2.64 17.07 7.77-5.24-11.42-10.26-5.31.06-.64 9 2.65-2.61-9.92-6.06-1.94v-1l5.66.9-1.3-9.58-4.8-.71-.05-.92h4.72l-.34-9.49h-4.9v-.81l4.94-.78.48-9.56-5.72.88v-.85l5.9-1.86 1.23-9.75-7.13 2.14v-1l7.51-3.55 2-10-9.1 4.06.11-1.56 9.85-6.12L181 77.94l-11.6 6.92.41-2.7 13-10 3.58-10.27L171.55 73l1.23-5.19L190.31 52l4.27-9.8L172.3 61l-3.3-.6 35.61-38.23ZM160 147a50 50 0 0 1-50 50 50 50 0 0 1-50-50V72h100Z" fill="url(#fr4-i)"/><path d="m108.32 50.83-.66-37.78h4.68l-.66 37.78h-3.36z" fill="url(#fr4-c)"/><path d="M111.1 220.44h-2.2l-1.21 32.06h4.62l-1.21-32.06z" fill="url(#fr4-j)"/><path d="m174.06 64.88 1.08-4.16-10.92 7.29h-3.14l7.8-8.52-5.22-.89-9.64 9.4h-2.5l6.1-10.43-4.6-.78-9.38 11.22h-2.38l4.83-12.41-3.62-.62-8.63 13.03h-2.27l3-14.32-2.76-.47-7.16 14.79h-2.17l.95-16.28-2.78-.34-4.38 16.62h-1.96l-2.63-18.18h-3.36L105.7 68h-1.96l-4.38-16.62-2.78.34.95 16.28h-2.17L88.2 53.22l-2.76.47 3 14.32h-2.28l-8.63-13.03-3.62.62L78.74 68h-2.38l-9.39-11.2-4.58.77 6.1 10.44h-2.51l-9.64-9.4-5.22.88 7.8 8.52h-3.14l-10.92-7.29 1.08 4.16 9.97 9.85v3.56l-7.74-2.8.84 4.25 6.9 4.36.01 4.45-5.85-2.02.66 5.98 5.2 2.17v4.23l-5.1-2.2.52 6.03 4.6 1.29v4.87l-4.48-1 .01 6.1 4.48.41v4.57l-4.55-.64-.2 6.72h4.76v4.5l-4.97.02-.3 5.42 5.28-.38.01 4.05-5.6.94-.28 5.8 5.89-.72V147l.02.6-5.95 2.56.22 5.44 6.24-1.1.47 2.79-6.16 3.47.8 4.58 6.86-2.1.89 2.57-6.22 5.08L55 175.5l7.4-3.02 2.05 3.47-7.72 5.74 4.64 3.2 6.86-3.71 2.34 2.65-4.56 5.59 4.39 3.9 5-4.9 2.88 2.24-3.28 6.1 5.57 3.72 3.24-6.28 3.17 1.63-2.45 6.68 6.02 3.71 3.33-7.68 2.97.83-1.3 10.27 3.36 2.4 3.1-11.64 3.43.4 2.86 20.63h3.4l2.86-20.64 3.42-.39 3.11 11.64 3.37-2.4-1.3-10.27 2.96-.83 3.33 7.68 6.02-3.7-2.45-6.69 3.17-1.63 3.24 6.28 5.58-3.72-3.29-6.1 2.88-2.24 5 4.9 4.39-3.9-4.56-5.59 2.34-2.65 6.86 3.72 4.64-3.21-7.72-5.74 2.04-3.47 7.4 3.02 1.84-4.6-6.22-5.09.89-2.56 6.86 2.09.8-4.58-6.16-3.47.47-2.8 6.24 1.1.22-5.43-5.95-2.56.02-.6v-2.32l5.9.72-.3-5.8-5.6-.94.01-4.05 5.29.38-.3-5.42-4.98-.01v-4.51h4.77l-.2-6.72-4.56.64.01-4.57 4.48-.4v-6.1l-4.47.99v-4.87l4.6-1.28.52-6.04-5.1 2.2v-4.23l5.2-2.17.66-5.98-5.86 2.02.01-4.45 6.91-4.36.84-4.25-7.74 2.8v-3.56ZM160 147.01a50 50 0 1 1-100 0V72h100Z" fill="url(#fr4-k)"/><use height="242.02" transform="matrix(-1 0 0 1 108.91 10.49)" width="100.04" xlink:href="#fr4-l"/><use height="242.02" transform="translate(111.09 10.49)" width="100.04" xlink:href="#fr4-l"/><path d="M110 198c-28.12 0-51-22.87-51-52V70.97h102v76A51.07 51.07 0 0 1 110 198Z" fill="none" stroke="url(#fr4-m)" stroke-width="2"/><path d="M160 72.01H60l-2-2h104l-2 2z" fill="url(#fr4-n)"/>'
          )
        )
      );
  }
}
