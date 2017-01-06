library IEEE, STD;
use IEEE.std_logic_1164.all;
use STD.textio.all;
--------------------------------------------------------------------------------
package junit is

    ----------------------------------------------------------------------------
    -- Procedure: JUnit XML Declaration
    -- * Outputs the XML declaration header to JUNIT_FILE
    ----------------------------------------------------------------------------
    procedure junit_xml_declaration (variable JUNIT_FILE : in text);

    ----------------------------------------------------------------------------
    -- Procedure: JUnit Start Testsuites
    -- * Opening <testsuites> tag
    ----------------------------------------------------------------------------
    procedure junit_start_testsuites (
        variable JUNIT_FILE : in text;
        ID : in string;
        NAME : in string;
        TESTS : in natural;
        FAILURES : in natural;
        RUNTIME : in time
    );

    ----------------------------------------------------------------------------
    -- Procedure: JUnit End Testsuites
    -- * Closing </testsuites> tag
    ----------------------------------------------------------------------------
    procedure junit_end_testsuites (variable JUNIT_FILE : in text);

    ----------------------------------------------------------------------------
    -- Procedure: JUnit Start Testsuite
    -- * Opening <testsuite> tag
    ----------------------------------------------------------------------------
    procedure junit_start_testsuite (
        variable JUNIT_FILE : in text;
        ID : in string;
        NAME : in string;
        TESTS : in natural;
        FAILURES : in natural;
        RUNTIME : in time
    );

    ----------------------------------------------------------------------------
    -- Procedure: JUnit End Testsuite
    -- * Closing </testsuite> tag
    ----------------------------------------------------------------------------
    procedure junit_end_testsuite (variable JUNIT_FILE : in text);

    ----------------------------------------------------------------------------
    -- Procedure: JUnit Start Testcase
    -- * Opening <testcase> tag
    ----------------------------------------------------------------------------
    procedure junit_start_testcase (
        variable JUNIT_FILE : in text;
        ID : in string;
        NAME : in string;
        RUNTIME : in time
    );


    ----------------------------------------------------------------------------
    -- Procedure: JUnit Testcase
    -- * Opening and closing <testcase> tags, with no content
    ----------------------------------------------------------------------------
    procedure junit_testcase (
        variable JUNIT_FILE : in text;
        ID : in string;
        NAME : in string;
        RUNTIME : in time
    );

    ----------------------------------------------------------------------------
    -- Procedure: JUnit End Testcase
    -- * Closing </testcase> tag
    ----------------------------------------------------------------------------
    procedure junit_end_testcase (variable JUNIT_FILE : in text);

    ----------------------------------------------------------------------------
    -- Procedure: JUnit Failure
    -- * <failure> tag and body
    ----------------------------------------------------------------------------
    procedure junit_failure (
        variable JUNIT_FILE : in text;
        MESSAGE : in string;
        DETAIL : in string
    );

    ----------------------------------------------------------------------------
    -- Procedure: JUnit Error
    -- * <error> tag and body
    ----------------------------------------------------------------------------
    procedure junit_error (
        variable JUNIT_FILE : in text;
        MESSAGE : in string;
        DETAIL : in string
    );

    ----------------------------------------------------------------------------
    -- Procedure: JUnit Skipped
    -- * <skipped /> self-closing tag
    ----------------------------------------------------------------------------
    procedure junit_skipped (variable JUNIT_FILE : in text);

    ----------------------------------------------------------------------------
    -- Function: JUnit Time
    -- * Converts simulation time to real seconds
    ----------------------------------------------------------------------------
    function junit_time (RUNTIME : in time) return real;

end junit;