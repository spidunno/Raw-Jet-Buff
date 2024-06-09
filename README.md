# Trailmakers Typescript Scaffolding Project

To get started run:

```bash
# Replace `<YOUR TRAILMAKERS MODS DIRECTORY>` with the
# actual directory to your Trailmakers mods folder.
cd "<YOUR TRAILMAKERS MODS DIRECTORY>"

# Feel free to change `my-trailmakers-project`
# to your desired project name here
npx degit spidunno/trailmakers-scaffolding "my-trailmakers-project"

# and here
cd "my-trailmakers-project"
```

Install dependencies with yarn/npm/bun:

```bash
npm install
```

Edit the `src/main.ts` file and build your project with:

```bash
npm run build
```

To watch for file changes and automatically re-build:

```bash
npm run watch
```

## Uploading
Copy the generated `main.lua` as well as the `data_static` folder into another folder and upload as usual. I might make a script that automatically does everything needed to prepare your mod to be uploaded later.
