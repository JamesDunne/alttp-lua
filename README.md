# alttp-lua
BizHawk emulator Lua scripts for The Legend of Zelda - A Link To The Past SNES title.

### 2019-08-30
Using Orochimaru's Zelda 3 Hacking Compendium PDF to discover RAM addresses of interesting values.

In this first iteration I have sprite tracking enabled, drawing the sprite kind value in hex over the sprite.

Camera offset was a little tricky to discover, but using BG2 horiz/vert scroll registers ($E2 $E8 pair) seems to work well in most cases; needs more testing to make sure it will work in all screens, dungeon, overworld, dark world, etc.

My intent is to discover Link's X,Y coordinates relative to screen top-left and know which screen he is in. Then transmit this data over a network link to another emulator running a client script to alter either OAM or the sprite data to project remote Link on screen if he's in the same screen as the local player.

Beyond this basic proof of concept, consider gameplay ways for players to actually interact since memory would not be shared in any direct way. Perhaps sync up various game state memory locations so that one player's actions affect the world for the other player like bosses defeated, pendants and crystals collected, chests opened, etc. Maybe a shared inventory would be useful. Local screens could also coordinate enemy state so that players could co-op through the game together. Might need to synchronize RNGs so control enemy behaviors and achieve determinism of game simulations in lock-step between clients.
