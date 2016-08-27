# IDTdesign index page

Built with [DocPad](http://docpad.org).


## Dependencies

* [node.js](http://nodejs.org/)
* [npm](https://npmjs.org)
* `npm install grunt-cli -g`

## First run

Clone the repository.

``` bash
$ npm install
$ grunt
```
Open [http://localhost:8888/]()

## Documentation

Browse [uicomponents](https://github.com/IDTdesign/bossxgen/tree/master/uicomponents) folder for docs.

## Publishing

Before first publishing run this command in GIT console
`git remote add deploy https://login:password@github.com/IDTdesign/bossxgen.git`

Where *login* and *password* is your Github credentials.

Then run `grunt deploy` — publish to [https://idtdesign.github.io/bossxgen/]()

More info http://paulradzkov.com/2014/deploy_docpad_site_to_github_pages/

## License

Copyright &copy; 2016 IDT Corp
