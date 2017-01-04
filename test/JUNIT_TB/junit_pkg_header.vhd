library IEEE, STD;
use IEEE.std_logic_1164.all;
use STD.textio.all;
--------------------------------------------------------------------------------
package junit is

    procedure junit_xml_declaration (
        variable JUNIT_FILE : in text
    );


    procedure junit_start_testsuites (
        variable JUNIT_FILE : in text;
        ID : in string;
        NAME : in string;
        TESTS : in natural;
        FAILURES : in natural;
        RUNTIME : in natural
    );


    procedure junit_end_testsuites (
        variable JUNIT_FILE : in text
    );


    procedure junit_start_testsuite (
        variable JUNIT_FILE : in text;
        ID : in string;
        NAME : in string;
        TESTS : in natural;
        FAILURES : in natural;
        RUNTIME : in natural
    );


    procedure junit_end_testsuite (
        variable JUNIT_FILE : in text
    );


    procedure junit_start_testcase (
        variable JUNIT_FILE : in text;
        ID : in string;
        NAME : in string;
        RUNTIME : in natural
    );


    procedure junit_testcase (
        variable JUNIT_FILE : in text;
        ID : in string;
        NAME : in string;
        RUNTIME : in natural
    );


    procedure junit_end_testcase (
        variable JUNIT_FILE : in text
    );


    procedure junit_failure (
        variable JUNIT_FILE : in text;
        MESSAGE : in string;
        DETAIL : in string
    );

end junit;