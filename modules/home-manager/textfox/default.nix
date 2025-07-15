{ config, pkgs, inputs, ... }:

imports = [ inputs.textfox.homeManagerModules.default ];

textfox = {
    enable = true;
    profile = "firefox profile name here";
    config = {
        # Optional config
    };
};
