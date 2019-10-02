# PharoJS: Develop in Pharo, Run on Javascript

To install PharoJS for Pharo 7 and above, perform the following code in a playground:

<pre>
Metacello new
  baseline: 'PharoJS';
  repository: 'github://bouraqadi/PharoJS';
  load
</pre>

More doc is available at: http://pharojs.org/

## Installing from source code
Clone the following repositories to your local machine:
```
https://github.com/bouraqadi/PharoMisc
https://github.com/svenvc/zinc
https://github.com/bouraqadi/PharoJS
```
* In Pharo, open Iceberg `Cmd+O+I`
* Add -> Import from existing clone -> locate PharoMisc
* Open PharoMisc from Iceberg and add the packages `PharoExtra`, `LightweightObserver`, and `Equals`
* Add -> Import from existing clone -> locate zinc
* Open zinc from Iceberg and add the package `Zinc-WebSocket-Core`
* Finally, Add -> Import from existing clone -> locate PharoJS
* Open PharoJS from Iceberg and add all packages
    * Note: Initially, some packages might be green, indicating that changes have been made
    * This can be resolved by re-loading them in some particular order until they're all up to date
