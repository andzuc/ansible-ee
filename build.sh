#!/bin/bash

tar -C context -cf - .|docker build --progress plain -t andzuc/ansible-ee -
