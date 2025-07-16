#!/usr/bin/env node

const fs = require('fs').promises;
const path = require('path');

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Symlink Dotfiles
// @raycast.mode fullOutput

// Optional parameters:
// @raycast.icon assets/extension-icon.png
// @raycast.iconDark assets/extension-icon.png
// @raycast.packageName Dotfiles

// Documentation:
// @raycast.description Symlinks dotfiles that end with a .link suffix
// @raycast.author Jhey
// @raycast.authorURL https://x.com/jh3yy

const LINKS_DIR = path.join(process.cwd(), 'links');
const HOME_DIR = process.env.HOME || process.env.USERPROFILE;
const FILE_SUFFIX = '.link';

function log(msg) {
  console.log(`[SYMLINK] ${msg}`);
}

async function* walk(dir) {
  for (const entry of await fs.readdir(dir, { withFileTypes: true })) {
    const res = path.resolve(dir, entry.name);
    if (entry.isDirectory()) {
      yield* walk(res);
    } else if (entry.isFile() && entry.name.endsWith(FILE_SUFFIX)) {
      yield res;
    }
  }
}

async function ensureDirExists(dir) {
  try {
    await fs.mkdir(dir, { recursive: true });
    log(`Created directory: ${dir}`);
  } catch (e) {
    if (e.code !== 'EEXIST') throw e;
  }
}

async function backupIfExists(target) {
  try {
    await fs.access(target);
    const backup = `${target}.bak`;
    await fs.copyFile(target, backup);
    log(`Backed up: ${target} → ${backup}`);
  } catch {}
}

async function createSymlink(source, target) {
  console.info({ source, target })
  await backupIfExists(target);
  try {
    await fs.unlink(target);
  } catch {}
  await fs.symlink(source, target);
  log(`Symlinked: ${target} → ${source}`);
}

function getTargetPath(sourceAbs) {
  const rel = path.relative(LINKS_DIR, sourceAbs);
  return path.join(HOME_DIR, rel.replace(FILE_SUFFIX, ''));
}

(async () => {
  log(`Starting dotfiles symlink process...`);
  for await (const source of walk(LINKS_DIR)) {
    const target = getTargetPath(source);
    await ensureDirExists(path.dirname(target));
    await createSymlink(source, target);
  }
  log('Symlink process completed!');
})();