function typescript-init-project
#!/usr/bin/env fish
function error_die -a msg
  echo "Error "$msg; and exit -1
end

nvm use 16; or error_die "couldn't set nvm version"
npm init; or error_die "couldn't npm init"
npm install --save-dev jest typescript ts-jest @types/jest @types/node; or error_die "couldn't install dev dependencies"
npx  ts-jest config:init; or error_die "couldn't init ts-jest"
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
npm run test
end
