{ config, pkgs, inputs, ... }:
{
textfox = {
    enable = true;
    profile = "firefox profile name here";
    config = {
    displayWindowControls = true;
    displayNavButtons = true;
    displayUrlbarIcons = true;
    displaySidebarTools = false;
    displayTitles = false;
    };
  };
}
