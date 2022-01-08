# Defined in /tmp/fish.7MvCDN/typescript-init-project.fish @ line 2
function typescript-init-project
#!/usr/bin/env fish
yarn set version berry
yarn init
yarn add --dev jest typescript
yarn add --dev ts-jest @types/jest
yarn ts-jest config:init
yarn dlx @yarnpkg/sdks vscode
npx npm-add-script -k "test" -v "jest"
tsconfig-get > ./tsconfig.json
gitignore-get > ./.gitignore
eslintrc-get > ./.eslintrc
mkdir src
touch src/index.ts
touch src/index.test.ts
echo "
  test(\"Let's get things started\", ()=>{
    expect(true).toBe(false)
  })
" > src/index.test.ts
yarn test
end
