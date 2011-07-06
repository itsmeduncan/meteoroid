# Meteoroid

Parsing JMeter ouput into something useful. It will aggregate the data by 
path.

### Install

    gem install meteoroid


### CLI Usage

    meteoroid Output.jml #=> Output.json
    meteoroid Output.jml foobar.json #=> foobar.json

### Gem Usage

    Meteoroid::Parser.parse!('/tmp/Output.jml') #=> {}
    Meteoroid::Parser.parse!('/tmp/Output.jml', '/tmp/Output2.jml') #=> {}

### Copyright

Copyright (c) 2011 Impossible Rocket, Inc. See LICENSE for further details.