# Meteoroid [![Build Status](http://travis-ci.org/itsmeduncan/meteoroid.png)](http://travis-ci.org/itsmeduncan/meteoroid)

This is currently under development. The functionality described below is the
goal of this project.

Parsing JMeter output into something useful.

### Install

    gem install meteoroid


### CLI Usage

    meteoroid Output.jml #=> Output.json
    meteoroid Output.jml Foobar.jml #=> Output.json

### Gem Usage

    Meteoroid::Parser.parse!('/tmp/Output.jml') #=> [Meteoroid::Sample, ...]
    Meteoroid::Parser.parse!('/tmp/Output.jml', '/tmp/Output2.jml') #=> [Meteoroid::Sample, ...]

### Copyright

Copyright (c) 2011 Impossible Rocket, Inc. See LICENSE for further details.