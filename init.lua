local S = core.get_translator("jc_memorial_blocks")


core.register_node("jc_memorial_blocks:lag_block", {
  description = "Show this around town to sho you love the original Just Test.  REMEMBER THE TEST.  Lag, This is a dedication block to your ideas, your server, and you.  My skuchayem i lyubyat vas.  WE MISS AND LOVE YOU!",
  tiles = {"default_water.png^treeprop.png^heart.png"},
  is_ground_content = false,
  walkable = false,
  light_source = core.LIGHT_MAX,
  groups = {immortal=1,cracky=1,not_in_creative_inventory = 1},
  sounds = default.node_sound_stone_defaults(),
})

---------------------------------------------------------
-- 2025 Memorial Block
---------------------------------------------------------

core.register_node("jc_memorial_blocks:2025", {
  description = S("2025 Memorial Block"),
  tiles = {
    "jc_memorial_blocks_2025_top.png",
    "jc_memorial_blocks_2025_bottom.png",
    "jc_memorial_blocks_2025_side.png",
    "jc_memorial_blocks_2025_side.png",
    "jc_memorial_blocks_2025_side.png",
    "jc_memorial_blocks_2025_side.png",
  },
  is_ground_content = false,
  groups = {cracky = 2,not_in_creative_inventory = 1},
  light_source = 10,
  sounds = default.node_sound_stone_defaults(),
})

---------------------------------------------------------
-- 2026 Memorial Block
---------------------------------------------------------

core.register_node("jc_memorial_blocks:2026", {
  description = S("2026 Memorial Block"),
  tiles = {
    "jc_memorial_blocks_2026_top.png",
    "jc_memorial_blocks_2026_bottom.png",
    "jc_memorial_blocks_2026_side.png",
    "jc_memorial_blocks_2026_side.png",
    "jc_memorial_blocks_2026_side.png",
    "jc_memorial_blocks_2026_side.png",
  },
  is_ground_content = false,
  groups = {cracky = 2,not_in_creative_inventory = 1},
  light_source = 10,
  sounds = default.node_sound_stone_defaults(),
})

---------------------------------------------------------
-- Heal players every 5 seconds
---------------------------------------------------------

local timer = 0

core.register_globalstep(function(dtime)
  timer = timer + dtime

  -- if timer < 5 then
    -- return
  -- end

  timer = 0

  for _, player in ipairs(core.get_connected_players()) do

    local pos = player:get_pos()

    local under = {
      x = math.floor(pos.x + 0.5),
      y = math.floor(pos.y - 0.2),
      z = math.floor(pos.z + 0.5),
    }

    local node = core.get_node(under)

    if node.name == "jc_memorial_blocks:2025" then

      -- Heal
      local hp = player:get_hp()
      if hp < 20 then
        player:set_hp(math.min(20, hp + 1))
      end

      -- Healing particles
      core.add_particlespawner({
        amount = 18,
        time = 1,

        minpos = vector.subtract(pos, {x=0.25,y=0.5,z=0.25}),
        maxpos = vector.add(pos, {x=0.25,y=1.2,z=0.25}),

        minvel = {x=-0.1,y=0.2,z=-0.1},
        maxvel = {x= 0.1,y=0.6,z= 0.1},

        minacc = {x=0,y=0,z=0},
        maxacc = {x=0,y=0.2,z=0},

        minexptime = 0.8,
        maxexptime = 1.6,

        minsize = 2,
        maxsize = 5,

        texture = "heart.png^[colorize:#66ff66:120",
        glow = 10,
      })
    elseif node.name == "jc_memorial_blocks:2026" then
      core.add_particlespawner({
        amount = 8,
        time = 1,

        minpos = vector.subtract(pos, {x=0.25,y=0.5,z=0.25}),
        maxpos = vector.add(pos, {x=0.25,y=1.2,z=0.25}),

        minvel = {x=-0.1,y=0.2,z=-0.1},
        maxvel = {x= 0.1,y=0.6,z= 0.1},

        minacc = {x=0,y=0,z=0},
        maxacc = {x=0,y=0.2,z=0},

        minexptime = 0.8,
        maxexptime = 1.6,

        minsize = 2,
        maxsize = 5,

        texture = "default_mese_crystal.png^[colorize:#2060FF:150",
        glow = 10,
      })
    end
  end
end)