tictac labtest readme
=====================

tictac.exe             -- oracle (linux version)
tictac.definitions.txt -- grammar of user inputs
at1.txt                -- instructor provided acceptance tests
at2.txt
testing                -- Haskell scripts to regression test 
                       -- actual vs. expected (oracle) outputs
(1) to execute the oracle:
        ./tictac.exe -b at1.txt

(2) To redirect to a file
        ./tictac.exe -b at1.txt > at1.expected.txt

(3) The testing directory has the Haskell testing scripts
for regression testing:
        ETF_TEST_Parameters.hs -- specify which tests to run
        etf_test.sh            -- script to run the tests

In the Parameters file. we have set a parameter 
        is_tolerant_on_white_spaces = True
This will allow a limited amount of tolerance to whitespace variants.
For example, at1.expected.txt has one less blank than in the first line
than the oracle. 

Usually, you will set 
        executable Linux  = "EIFGENs/registry/W_code/registry"
i.e. this is your project under development which produces 
your actual output. If the regression test script indicates a failure
in one of your acceptance tests, then fix your code & recompile,
then re-run the the regression tests. 
Please set up the parameters file carefully. 

You execute the tests by running the bash script:
        ./etf_test.sh 



This produces ==>
....
Running ./ETF_Test
....

=========================
Test Results: 2/2 passed.
=========================
Success: ./log/at1.expected.txt and ./log/at1.actual.txt are identical.
Success: ./log/at2.expected.txt and ./log/at2.actual.txt are identical.
=========================
Test Results: 2/2 passed.
=========================

To see whitespace in an editor:
===============================
(1) Use the "vim" editor
(2) Do the following:
   :syntax on
   :set syntax=whitespace

