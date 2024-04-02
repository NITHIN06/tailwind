npm init -y > /dev/null
printf "\n\n ->  npm init completed **"

npm install -D tailwindcss > /dev/null
npx tailwindcss init > /dev/null
printf "\n\n ->  Tailwind CSS installed and initiated **"


cat << EOF > tailwind.config.js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./*.{html,js}"],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF

printf "\n\n ->  tailwind.comfig.js updated **"

mkdir -p css
cat << EOF > input.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

printf "\n\n ->  css/input.css created and updated **"

sudo apt-get install jq > /dev/null

watch_command="tailwindcss -i input.css -o ./css/index.css --watch"
build_command="tailwindcss -i input.css -o ./css/index.css"

if [ -f "package.json" ]; then
    jq --arg cmd "$build_command" --arg watch_cmd "$watch_command" '.scripts += { "watch": $watch_cmd, "build": $cmd }' package.json > temp.json && mv temp.json package.json
    printf "\n\n ->  \"watch\" and \"build\" script added to package.json. **"
else
    printf "\n\n ->  package.json not found. **"
fi


cat << EOF > index.html
<!doctype html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="./css/index.css" rel="stylesheet">
</head>
<body>
  <h1 class="text-3xl font-bold underline">
    Hello world!
  </h1>
</body>
</html>
EOF

printf "\n\n ->  Initialized index.html **\n"


npm run watch