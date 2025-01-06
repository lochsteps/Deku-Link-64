-- name: [CS] Deku Link
-- description: A Template for Character Select to build off of when making your own pack!\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

--[[
    API Documentation for Character Select can be found below:
    https://github.com/Squishy6094/character-select-coop/wiki/API-Documentation

    Use this if you're curious on how anything here works >v<
]]

local TEXT_MOD_NAME = "Deku Link"

-- Stops mod from loading if Character Select isn't on
if not _G.charSelectExists then
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
    return 0
end

local E_MODEL_CUSTOM_MODEL = smlua_model_util_get_id("dekulink_geo") -- Located in "actors"

local TEX_CUSTOM_LIFE_ICON = get_texture_info("dekuicon") -- Located in "textures"
local TEX_CUSTOM_STAR_ICON = get_texture_info("staricon") -- Located in "textures"

-- All Located in "sound"
local VOICETABLE_DEKULINK = {
    [CHAR_SOUND_ATTACKED] = 'Deku-Hurt.ogg',
    [CHAR_SOUND_DOH] = 'Deku-Bonk.ogg',
    [CHAR_SOUND_DROWNING] = 'Game-Over.ogg',
    [CHAR_SOUND_DYING] = 'Game-Over.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'Deku-Haa.ogg',
    [CHAR_SOUND_HAHA] = 'Deku-Haa.ogg',
    [CHAR_SOUND_HAHA_2] = 'Deku-Haa2.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'Mask.ogg',
    [CHAR_SOUND_HOOHOO] = 'Deku-Jump2.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'Deku-Bonk.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'Deku-Haa2.ogg',
    [CHAR_SOUND_ON_FIRE] = 'Deku-Fall.ogg',
    [CHAR_SOUND_OOOF] = 'Deku-Hurt2.ogg',
    [CHAR_SOUND_OOOF2] = 'Deku-Hurt3.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'Deku-Haa.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'Deku-Haa2.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'Deku-Haa.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'Deku-Haa2.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'Deku-Flower.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'Deku-Fall.ogg',
    [CHAR_SOUND_WAH2] = 'Deku-Jump.ogg',
    [CHAR_SOUND_WHOA] = 'Deku-Oof.ogg',
    [CHAR_SOUND_YAHOO] = 'Deku-Jump.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = 'Deku-Jump.ogg',
    [CHAR_SOUND_YAH_WAH_HOO] = 'Deku-Jump2.ogg',
    [CHAR_SOUND_YAWNING] = 'Deku-Oof.ogg',
}

-- All Located in "actors"
local CAPTABLE_DEKULINK = {
    normal = smlua_model_util_get_id("dekunormal_geo"),
    wing = smlua_model_util_get_id("dekuwing_geo"),
    metal = smlua_model_util_get_id("dekumetal_geo"),
    metalWing = smlua_model_util_get_id("dekucapwing_geo"),
}

local E_MODEL_CUSTOM_STAR = smlua_model_util_get_id("custom_model_star_geo") -- Located in "actors"

local PALETTE_CHAR = {
    [PANTS]  = "ffffff",
    [SHIRT]  = "ffffff",
    [GLOVES] = "ffffff",
    [SHOES]  = "ffffff",
    [HAIR]   = "ffffff",
    [SKIN]   = "ffffff",
    [CAP]    = "ffffff",
}

--[[
-- All Located in "textures"
local healthMeter = {
    label = {
        left = get_texture_info("template-hp-back-left"),
        right = get_texture_info("template-hp-back-right"),
    },
    pie = {
        [1] = get_texture_info("template-hp-pie-1"),
        [2] = get_texture_info("template-hp-pie-2"),
        [3] = get_texture_info("template-hp-pie-3"),
        [4] = get_texture_info("template-hp-pie-4"),
        [5] = get_texture_info("template-hp-pie-5"),
        [6] = get_texture_info("template-hp-pie-6"),
        [7] = get_texture_info("template-hp-pie-7"),
        [8] = get_texture_info("template-hp-pie-8"),
    }
}
]]

--[[
    Note: If there are some functionalities you don't care
    to add such as palettes, you can freely remove the function
    for it, the only function you require is character_add
]]

local CSloaded = false
local function on_character_select_load()
    CT_CHAR = _G.charSelect.character_add("Deku Link", {"You've been met with a terrible", "fate, haven't you?"}, "nessie.", {r = 255, g = 200, b = 200}, E_MODEL_CUSTOM_MODEL, CT_MARIO, TEX_CUSTOM_LIFE_ICON)
    _G.charSelect.character_add_caps(E_MODEL_CUSTOM_MODEL, CAPTABLE_DEKULINK)
    _G.charSelect.character_add_voice(E_MODEL_CUSTOM_MODEL, VOICETABLE_DEKULINK)
    _G.charSelect.character_add_palette_preset(E_MODEL_CUSTOM_MODEL, PALETTE_CHAR)
    --_G.charSelect.character_add_health_meter(CT_CHAR, healthMeter)

    CSloaded = true
end

local function on_character_sound(m, sound)
    if not CSloaded then return end
    if _G.charSelect.character_get_voice(m) == VOICETABLE_DEKULINK then return _G.charSelect.voice.sound(m, sound) end
end

local function on_character_snore(m)
    if not CSloaded then return end
    if _G.charSelect.character_get_voice(m) == VOICETABLE_DEKULINK then return _G.charSelect.voice.snore(m) end
end

hook_event(HOOK_ON_MODS_LOADED, on_character_select_load)
hook_event(HOOK_CHARACTER_SOUND, on_character_sound)
hook_event(HOOK_MARIO_UPDATE, on_character_snore)