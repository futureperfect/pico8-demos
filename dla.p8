pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- Diffusion-Limited Aggregation Demo
-- by Erik Hollembeak

particles = {}

for i=0,25 do
  add(particles, {
    x = rnd(128),
    y = rnd(128),
    c = rnd(16),
    vx = rnd(5) -2.5,
    vy = rnd(2) -1,
  })
end

stationary = {}

add(stationary, {
  x = 64,
  y = 64,
  c = 16,
  vx = 0,
  vy = 0,
})

function _draw()
  cls()
  for p in all(particles) do
    pset(p.x, p.y, p.c)
  end

  for s in all(stationary) do
    pset(s.x, s.y, s.c)
  end
end

function _update()
  update_position()
  detect_collisions()
end

function update_position()
  for p in all(particles) do
    p.x = (p.x + p.vx) % 128
    p.y = (p.y + p.vy) % 128
  end
end

function detect_collisions()
  for p in all(particles) do
    for s in all(stationary) do
      if near(p, s) then
        del(particles, p)
        add(stationary, p)
        spawn_particle()
        break
      end
    end
  end
end

function distance(x1, y1, x2, y2)
  return (x2 - x1)^2 + (y2 - y1)^2
end

function near(p1, p2)
  if distance(p1.x, p1.y, p2.x, p2.y) < 2 then
    return true
  else
    return false
  end
end

function spawn_particle()
  add(particles, {
    x = rnd(128),
    y = rnd(128),
    c = rnd(16),
    vx = rnd(5) -2.5,
    vy = rnd(2) -1,
  })
end
