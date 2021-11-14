#!/usr/bin/bash
patch -p1 < alpha.patch
patch -p1 < center.patch
sudo make install
