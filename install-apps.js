#!/usr/bin/env node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Install Apps
// @raycast.mode fullOutput

// Optional parameters:
// @raycast.icon assets/extension-icon.png
// @raycast.iconDark assets/extension-icon.png
// @raycast.packageName Dotfiles

// Documentation:
// @raycast.description Installs Homebrew and desired apps, casks, etc. from Brewfile
// @raycast.author Jhey
// @raycast.authorURL https://x.com/jh3yy

const { execSync, spawnSync } = require("child_process");
const path = require("path");
const fs = require("fs");

const brewfilePath = path.join(process.cwd(), "files/Brewfile");

if (!fs.existsSync(brewfilePath)) {
  console.error(`Brewfile not found at ${brewfilePath}`);
  process.exit(1);
}

function hasBrew() {
  try {
    execSync("command -v brew", { stdio: "ignore" });
    return true;
  } catch {
    return false;
  }
}

if (!hasBrew()) {
  console.log("Homebrew not found. Installing...");
  try {
    execSync('/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"', { stdio: "inherit" });
  } catch (e) {
    console.error("Failed to install Homebrew.");
    process.exit(1);
  }
}

console.log("Running brew bundle...");
const result = spawnSync("brew", ["bundle", "--file", brewfilePath], { stdio: "inherit" });
if (result.error || result.status !== 0) {
  process.exit(result.status || 1);
}