-- Copyright (c) 2016 Miro Mannino
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this
-- software and associated documentation files (the "Software"), to deal in the Software
-- without restriction, including without limitation the rights to use, copy, modify, merge,
-- publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
-- to whom the Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies
-- or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
-- INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
-- PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
-- FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
-- OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
-- DEALINGS IN THE SOFTWARE.
-- added additional sizes
-- set all keyboard shortcut bindings at once based on shortcuts variable set in init.lua
hs.window.animationDuration = 0
-- elements in sizes reflect denominators under 1
-- e.g. 2 => 1/2
local sizes = {2, 3, 4, 3/2, 4/3}
local fullScreenSizes = {1, 4/3, 2}
local GRID = {w = 24, h = 24}
hs.grid.setGrid(GRID.w .. 'x' .. GRID.h)
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
local pressed = {
  up = false,
  down = false,
  left = false,
  right = false
}
function nextStep(dim, offs, cb)
  if hs.window.focusedWindow() then
    local axis = dim == 'w' and 'x' or 'y'
    local oppDim = dim == 'w' and 'h' or 'w'
    local oppAxis = dim == 'w' and 'y' or 'x'
    local win = hs.window.frontmostWindow()
    local id = win:id()
    local screen = win:screen()
    cell = hs.grid.get(win, screen)
    local nextSize = sizes[1]
    for i=1,#sizes do
      if cell[dim] == GRID[dim] / sizes[i] and
        (cell[axis] + (offs and cell[dim] or 0)) == (offs and GRID[dim] or 0)
        then
          nextSize = sizes[(i % #sizes) + 1]
        break
      end
    end
    cb(cell, nextSize)
    if cell[oppAxis] ~= 0 and cell[oppAxis] + cell[oppDim] ~= GRID[oppDim] then
      cell[oppDim] = GRID[oppDim]
      cell[oppAxis] = 0
    end
    hs.grid.set(win, cell, screen)
  end
end
function nextFullScreenStep()
  if hs.window.focusedWindow() then
    local win = hs.window.frontmostWindow()
    local id = win:id()
    local screen = win:screen()
    cell = hs.grid.get(win, screen)
    local nextSize = fullScreenSizes[1]
    for i=1,#fullScreenSizes do
      if cell.w == GRID.w / fullScreenSizes[i] and
         cell.h == GRID.h / fullScreenSizes[i] and
         cell.x == (GRID.w - GRID.w / fullScreenSizes[i]) / 2 and
         cell.y == (GRID.h - GRID.h / fullScreenSizes[i]) / 2 then
        nextSize = fullScreenSizes[(i % #fullScreenSizes) + 1]
        break
      end
    end
    cell.w = GRID.w / nextSize
    cell.h = GRID.h / nextSize
    cell.x = (GRID.w - GRID.w / nextSize) / 2
    cell.y = (GRID.h - GRID.h / nextSize) / 2
    hs.grid.set(win, cell, screen)
  end
end
hs.hotkey.bind(hyper, "f", function () nextFullScreenStep() end)
function fullDimension(dim)
  if hs.window.focusedWindow() then
    local win = hs.window.frontmostWindow()
    local id = win:id()
    local screen = win:screen()
    cell = hs.grid.get(win, screen)
    if (dim == 'x') then
      cell = '0,0 ' .. GRID.w .. 'x' .. GRID.h
    else
      cell[dim] = GRID[dim]
      cell[dim == 'w' and 'x' or 'y'] = 0
    end
    hs.grid.set(win, cell, screen)
  end
end
function resizeTowardBottom()
  pressed.down = true
  if pressed.up then
    fullDimension('h')
  else
    nextStep('h', true, function (cell, nextSize)
      cell.y = GRID.h - GRID.h / nextSize
      cell.h = GRID.h / nextSize
    end)
  end
end
hs.hotkey.bind(hyper, "down", resizeTowardBottom, function () pressed.down = false end)
hs.hotkey.bind(hyper, "j", resizeTowardBottom, function () pressed.down = false end)
function resizeTowardRight()
  pressed.right = true
  if pressed.left then
    fullDimension('w')
  else
    nextStep('w', true, function (cell, nextSize)
      cell.x = GRID.w - GRID.w / nextSize
      cell.w = GRID.w / nextSize
    end)
  end
end
hs.hotkey.bind(hyper, "right", resizeTowardRight, function () pressed.right = false end)
hs.hotkey.bind(hyper, "l", resizeTowardRight, function () pressed.right = false end)
function resizeTowardLeft()
  pressed.left = true
  if pressed.right then
    fullDimension('w')
  else
    nextStep('w', false, function (cell, nextSize)
      cell.x = 0
      cell.w = GRID.w / nextSize
    end)
  end
end
hs.hotkey.bind(hyper, "left", resizeTowardLeft, function () pressed.left = false end)
hs.hotkey.bind(hyper, "h", resizeTowardLeft, function () pressed.left = false end)
function resizeTowardTop()
  pressed.up = true
  if pressed.down then
      fullDimension('h')
  else
    nextStep('h', false, function (cell, nextSize)
      cell.y = 0
      cell.h = GRID.h / nextSize
    end)
  end
end
hs.hotkey.bind(hyper, "up", resizeTowardTop, function () pressed.up = false end)
hs.hotkey.bind(hyper, "k", resizeTowardTop, function () pressed.up = false end)
function showPositionInfo()
  local win = hs.window.frontmostWindow()
  local id = win:id()
  local screen = win:screen()
  cell = hs.grid.get(win, screen)
  hs.alert.show(cell)
end
hs.hotkey.bind(hyper, "i", showPositionInfo)
