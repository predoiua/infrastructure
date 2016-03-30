#!/bin/sh
exec scala "$0" "$@"
!#
import sys.process._
//execute an os command
Seq("bash", "-c", "touch hello_world_file").!!
object HelloWorld extends App {
  println("Hello, world!")
}
HelloWorld.main(args)
