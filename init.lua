local S = core.get_translator("jc_memorial_blocks")

local healing_sounds = {}
local satiation_sounds = {}
local sound_check_timer = 0
local memorial_sounds_disabled = {}

local infotext_lag_block = "Show this around town to show you love the original Just Test. REMEMBER THE TEST. Lag, This is a dedication block to your ideas, your server, and you. My skuchayem i lyubyat vas. WE MISS AND LOVE YOU!"
local infotext_memorial_block_2025 = "2025 Memorial Block"
local infotext_memorial_block_2026 = "2026 Memorial Block"

local function start_memorial_timer(pos)
  local timer = core.get_node_timer(pos)
  if not timer:is_started() then
    timer:start(2.0)
  end
end

-- ========================
-- Lag Block (unchanged)
-- ========================
core.register_node("jc_memorial_blocks:lag_block", {
  description = infotext_lag_block,
  short_description = infotext_lag_block,
  tiles = {"default_water.png^treeprop.png^heart.png"},
  is_ground_content = false,
  walkable = false,
  light_source = core.LIGHT_MAX,
  groups = {immortal=1, cracky=1, not_in_creative_inventory = 1},
  sounds = default.node_sound_stone_defaults(),

  on_construct = function(pos)
    local meta = core.get_meta(pos)
    meta:set_string("infotext", infotext_lag_block)
  end,
  on_punch = function(pos)
    local meta = core.get_meta(pos)
    meta:set_string("infotext", infotext_lag_block)
  end,
})

-- ========================
-- 2025 Memorial Block
-- ========================
core.register_node("jc_memorial_blocks:2025", {
  description = S("2025 Memorial Block"),
  short_description = S("2025 Memorial Block"),
  tiles = {
    "jc_memorial_blocks_2025_top.png",
    "jc_memorial_blocks_2025_bottom.png",
    "jc_memorial_blocks_2025_side.png",
    "jc_memorial_blocks_2025_side.png",
    "jc_memorial_blocks_2025_side.png",
    "jc_memorial_blocks_2025_side.png",
  },
  is_ground_content = false,
  groups = {cracky = 2, not_in_creative_inventory = 1},
  light_source = 10,
  sounds = default.node_sound_stone_defaults(),

  on_construct = function(pos)
    local meta = core.get_meta(pos)
    meta:set_string("infotext", infotext_memorial_block_2025)
    start_memorial_timer(pos)
  end,

  on_punch = function(pos)
    local meta = core.get_meta(pos)
    meta:set_string("infotext", infotext_memorial_block_2025)
    start_memorial_timer(pos)
  end,

  -- Healing effect when player is nearby
  on_timer = function(pos, elapsed)
    for _, player in ipairs(core.get_connected_players()) do
      local ppos = player:get_pos()
      if vector.distance(pos, ppos) <= 1.2 then
        -- Heal player
        local hp = player:get_hp()
        if hp < 20 then
          player:set_hp(math.min(20, hp + 1))
        end

        -- Healing particles near player
        core.add_particlespawner({
          amount = 3,
          time = 1.8,
          minpos = vector.subtract(ppos, {x=0.4, y=0.4, z=0.4}),
          maxpos = vector.add(ppos, {x=0.4, y=1.0, z=0.4}),
          minvel = {x=-0.1, y=0.1, z=-0.1},
          maxvel = {x=0.1, y=0.35, z=0.1},
          minacc = {x=0, y=-0.05, z=0},
          maxacc = {x=0, y=0.1, z=0},
          minexptime = 2,
          maxexptime = 3.5,
          minsize = 2.5,
          maxsize = 5,
          texture = "heart.png^[colorize:#66ff66:180",
          glow = 12,
        })
      end
    end
    return true  -- Repeat timer
  end,
})

-- ========================
-- 2026 Memorial Block
-- ========================
core.register_node("jc_memorial_blocks:2026", {
  description = S("2026 Memorial Block"),
  short_description = S("2026 Memorial Block"),
  tiles = {
    "jc_memorial_blocks_2026_top.png",
    "jc_memorial_blocks_2026_bottom.png",
    "jc_memorial_blocks_2026_side.png",
    "jc_memorial_blocks_2026_side.png",
    "jc_memorial_blocks_2026_side.png",
    "jc_memorial_blocks_2026_side.png",
  },
  is_ground_content = false,
  groups = {cracky = 2, not_in_creative_inventory = 1},
  light_source = 10,
  sounds = default.node_sound_stone_defaults(),

  on_construct = function(pos)
    local meta = core.get_meta(pos)
    meta:set_string("infotext", infotext_memorial_block_2026)
    start_memorial_timer(pos)
  end,

  on_punch = function(pos)
    local meta = core.get_meta(pos)
    meta:set_string("infotext", infotext_memorial_block_2026)
    start_memorial_timer(pos)
  end,

  -- Hunger effect when player is nearby
  on_timer = function(pos, elapsed)
    for _, player in ipairs(core.get_connected_players()) do
      local ppos = player:get_pos()
      if vector.distance(pos, ppos) <= 1.2 then
        -- Feed player
        local name = player:get_player_name()
        if hbhunger and hbhunger.hunger[name] then
          hbhunger.hunger[name] = math.min(hbhunger.SAT_MAX, hbhunger.hunger[name] + 1)
          hbhunger.set_hunger_raw(player)
        end

        -- Hunger particles near player
        core.add_particlespawner({
          amount = 3,
          time = 1.8,
          minpos = vector.subtract(ppos, {x=0.4, y=0.4, z=0.4}),
          maxpos = vector.add(ppos, {x=0.4, y=1.0, z=0.4}),
          minvel = {x=-0.1, y=0.1, z=-0.1},
          maxvel = {x=0.1, y=0.35, z=0.1},
          minacc = {x=0, y=-0.05, z=0},
          maxacc = {x=0, y=0.1, z=0},
          minexptime = 2,
          maxexptime = 3.5,
          minsize = 2.5,
          maxsize = 5,
          texture = "farming_bread.png^[colorize:#FFEE88:200",
          glow = 12,
        })
      end
    end
    return true
  end,
})

core.register_globalstep(function(dtime)
  sound_check_timer = sound_check_timer + dtime
  if sound_check_timer < 1 then
    return
  end
  sound_check_timer = 0

  for _, player in ipairs(core.get_connected_players()) do
    local name = player:get_player_name()
    local ppos = player:get_pos()

    local found_2025 = false
    local found_2026 = false

    local meta = player:get_meta()

    if meta:get_string("memorial_sounds") == "off" then
      if healing_sounds[name] then
        core.sound_stop(healing_sounds[name])
        healing_sounds[name] = nil
      end

      if satiation_sounds[name] then
        core.sound_stop(satiation_sounds[name])
        satiation_sounds[name] = nil
      end

      goto continue
    end

    -- Search the same area that the block effects use
    for x = -1, 1 do
      for y = -1, 1 do
        for z = -1, 1 do
          local pos = {
            x = math.floor(ppos.x) + x,
            y = math.floor(ppos.y) + y,
            z = math.floor(ppos.z) + z,
          }

          local node = core.get_node_or_nil(pos)

          if node then
            if node.name == "jc_memorial_blocks:2025" then
              if vector.distance(pos, ppos) <= 1.2 then
                found_2025 = true
              end
            elseif node.name == "jc_memorial_blocks:2026" then
              if vector.distance(pos, ppos) <= 1.2 then
                found_2026 = true
              end
            end
          end

        end
      end
    end

    -- 2025 healing sound
    if found_2025 then
      if not healing_sounds[name] then
        healing_sounds[name] = core.sound_play("healing", {
          to_player = name,
          gain = 0.1,
          loop = true,
        })
      end
    elseif healing_sounds[name] then
      core.sound_stop(healing_sounds[name])
      healing_sounds[name] = nil
    end

    -- 2026 satiation sound
    if found_2026 then
      if not satiation_sounds[name] then
        satiation_sounds[name] = core.sound_play("satiation", {
          to_player = name,
          gain = 0.1,
          loop = true,
        })
      end
    elseif satiation_sounds[name] then
      core.sound_stop(satiation_sounds[name])
      satiation_sounds[name] = nil
    end

    ::continue::
  end
end)

core.register_on_leaveplayer(function(player)
  local name = player:get_player_name()

  if healing_sounds[name] then
    core.sound_stop(healing_sounds[name])
    healing_sounds[name] = nil
  end

  if satiation_sounds[name] then
    core.sound_stop(satiation_sounds[name])
    satiation_sounds[name] = nil
  end
end)

core.register_chatcommand("memorial_sounds", {
  params = "<on|off>",
  description = "Enable or disable memorial block sounds.",
  func = function(name, param)
    local player = core.get_player_by_name(name)
    if not player then
      return false, "Player not found."
    end

    local meta = player:get_meta()
    param = param:lower()

    if param == "off" then
      meta:set_string("memorial_sounds", "off")

      if healing_sounds[name] then
        core.sound_stop(healing_sounds[name])
        healing_sounds[name] = nil
      end

      if satiation_sounds[name] then
        core.sound_stop(satiation_sounds[name])
        satiation_sounds[name] = nil
      end

      core.log("action", "[MEMORIAL BLOCK SOUNDS] " .. name .. " turned _OFF_ sounds")

      return true, "Memorial block sounds disabled."

    elseif param == "on" then
      meta:set_string("memorial_sounds", "on")

      core.log("action", "[MEMORIAL BLOCK SOUNDS] " .. name .. " turned ON sounds")

      return true, "Memorial block sounds enabled."
    end

    return false, "Usage: /memorial_sounds <on|off>"
  end,
})