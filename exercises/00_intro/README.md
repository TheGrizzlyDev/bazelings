# 00 - Intro

## Running lessons

Each lesson is an individual bazel test. You can execute them by running `bazel test //exercises:<lesson_name>_test`. Let's try that by running this lesson:

```
bazel test //exercises:00_intro_test
```

Ooops, this test didn't work! You can tell that by the output at the end:

```
ERROR: /home/antonio/.cache/bazel/_bazel_antonio/454fa3384c947de8d1582530169f20a8/sandbox/linux-sandbox/50/execroot/_main/bazel-out/k8-fastbuild/bin/exercises/00_intro_test.runfiles/_main/exercises/00_intro/BUILD.bazel:3:8: in cmd attribute of genrule rule //:hello_world: $(OUTPUTS) not defined
ERROR: /home/antonio/.cache/bazel/_bazel_antonio/454fa3384c947de8d1582530169f20a8/sandbox/linux-sandbox/50/execroot/_main/bazel-out/k8-fastbuild/bin/exercises/00_intro_test.runfiles/_main/exercises/00_intro/BUILD.bazel:3:8: Analysis of target '//:hello_world' failed
ERROR: Analysis of target '//:hello_world' failed; build aborted
INFO: Elapsed time: 4.793s, Critical Path: 0.02s
INFO: 1 process: 1 internal.
ERROR: Build did NOT complete successfully
ERROR: No test targets were found, yet testing was requested
FAIL: //exercises:00_intro_test (Exit 1) (see /home/antonio/.cache/bazel/_bazel_antonio/454fa3384c947de8d1582530169f20a8/execroot/_main/bazel-out/k8-fastbuild/testlogs/exercises/00_intro_test/test.log)
ERROR: /home/antonio/src/bazelings/exercises/BUILD.bazel:12:27: Testing //exercises:00_intro_test failed: Test failed, aborting
Target //exercises:00_intro_test up-to-date:
  bazel-bin/exercises/00_intro_test
ERROR: Test failed, aborting
```

Here Bazel is giving us quite a few hints, but let's not worry about that right now and try fixing the test instead. Let's change line 6 in BUILD.bazel to:

```
    cmd  = "echo 'Hello, World!' > $(OUTS)"
```

and the run again the tests and you should see something like the following:

```
Executed 1 out of 1 test: 1 test passes.
INFO: Found 1 test target...
Target //exercises:00_intro_test up-to-date:
  bazel-bin/exercises/00_intro_test
INFO: Elapsed time: 23.825s, Critical Path: 23.77s
INFO: 2 processes: 2 linux-sandbox.
INFO: Build completed successfully, 2 total actions
//exercises:00_intro_test                                                PASSED in 23.7s
```

Yay! The test is finally passing! Taking this same approach, you can advance one lesson at a time through the end of the course. If at any point you want to try running all the lessons to see if you're missing any of them, you can run:

```
bazel test //exercises:*
```

With that said, good luck and see you on the next lesson!