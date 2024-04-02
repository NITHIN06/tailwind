npm init -y
echo "** npm init completed **"

npm install -D tailwindcss
npx tailwindcss init
echo "** Tailwind CSS installed and initiated **"

content = "/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./*.{html,js}"],
  theme: {
    extend: {},
  },
  plugins: [],
}"

echo "$lines_to_add" >> tailwind.config.js
echo "tailwind.comfig.js updated"

mkdir -p css
cat << EOF > css/input.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

echo "css/input.css created and updated"

sudo apt-get install jq

watch_command="tailwindcss -i .input.css -o ./src/index.css --watch"
build_command="tailwindcss -i .input.css -o ./src/index.css"

if [ -f "package.json" ]; then
    jq --arg cmd "$build_command" --arg watch_cmd "$watch_command" '.scripts += { "watch": $watch_cmd, "build": $cmd }' package.json > temp.json && mv temp.json package.json
    echo "\"watch\" and \"build\" script added to package.json."
else
    echo "package.json not found."
fi

content="<!doctype html>
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
</html>"

echo -e "$content" > index.html


echo "Initialized index.html"