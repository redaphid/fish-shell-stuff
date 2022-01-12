function typescript-init-project
#!/usr/bin/env fish
yarn set version berry
yarn init --workspace
yarn add --dev jest typescript
yarn add --dev ts-jest @types/jest
yarn add --dev @types/node
yarn ts-jest config:init
yarn dlx @yarnpkg/sdks vscode
npx npm-add-script -k "test" -v "jest"
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
