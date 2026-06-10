name = "Wilson Skill Tree Rework"
description =
"A rework to Wilson's Skill Tree, preserving his original jack of all trades beginner friendly character type with many new improvements."
author = "escondido222"
version = "0.2.2"
forumthread = ""

icon_atlas = "images/wilson_sigma_3.xml"
icon = "wilson_sigma_3.tex"

priority = -1
api_version = 10

configuration_options = {
    {
        name    = "revert_alchemy",
        label   =
        "Original Alchemy Skill Tree",
        hover   =
        "Respec skill tree after changing this setting. Recommended to use with mods such as Heap of Foods.",
        options = {
            { description = "Off (default)", data = false },
            { description = "On (original)", data = true },
        },
        default = false,
    },
}

client_only_mod = false
all_clients_require_mod = true
dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = true
