library IEEE, STD;
use IEEE.std_logic_1164.all;
use STD.textio.all;
--------------------------------------------------------------------------------
package body junit is

    ----------------------------------------------------------------------------
    -- Procedure: JUnit XML Declaration
    ----------------------------------------------------------------------------
    procedure junit_xml_declaration (
        variable JUNIT_FILE : in text
    ) is
        variable L : line;
    begin
        write(L, string'("<?xml version=""1.0"" encoding=""UTF-8"" ?>"));
        writeline(JUNIT_FILE, L);
    end procedure junit_xml_declaration;

    ----------------------------------------------------------------------------
    -- Procedure: JUnit Start Testsuites
    ----------------------------------------------------------------------------
    procedure junit_start_testsuites (
        variable JUNIT_FILE : in text;
        ID : in string;
        NAME : in string;
        TESTS : in natural;
        FAILURES : in natural;
        RUNTIME : in time
    ) is
        variable L : line;
    begin
        write(L, string'("<testsuites id="""));
        write(L, ID);
        write(L, string'(""" name="""));
        write(L, NAME);
        write(L, string'(""" tests="""));
        write(L, TESTS);
        write(L, string'(""" failures="""));
        write(L, FAILURES);
        write(L, string'(""" time="""));
        write(L, junit_time(RUNTIME), right, 0, 9);
        write(L, string'(""">"));
        writeline(JUNIT_FILE, L);
    end procedure junit_start_testsuites;

    ----------------------------------------------------------------------------
    -- Procedure: JUnit End Testsuites
    ----------------------------------------------------------------------------
    procedure junit_end_testsuites (variable JUNIT_FILE : in text) is
        variable L : line;
    begin
        write(L, string'("</testsuites>"));
        writeline(JUNIT_FILE, L);
    end procedure junit_end_testsuites;

    ----------------------------------------------------------------------------
    -- Procedure: JUnit Start Testsuite
    ----------------------------------------------------------------------------
    procedure junit_start_testsuite (
        variable JUNIT_FILE : in text;
        ID : in string;
        NAME : in string;
        TESTS : in natural;
        FAILURES : in natural;
        RUNTIME : in time
    ) is
        variable L : line;
    begin
        write(L, string'("<testsuite id="""));
        write(L, ID);
        write(L, string'(""" name="""));
        write(L, NAME);
        write(L, string'(""" tests="""));
        write(L, TESTS);
        write(L, string'(""" failures="""));
        write(L, FAILURES);
        write(L, string'(""" time="""));
        write(L, junit_time(RUNTIME), right, 0, 9);
        write(L, string'(""">"));
        writeline(JUNIT_FILE, L);
    end procedure junit_start_testsuite;

    ----------------------------------------------------------------------------
    -- Procedure: JUnit End Testsuite
    ----------------------------------------------------------------------------
    procedure junit_end_testsuite (variable JUNIT_FILE : in text) is
        variable L : line;
    begin
        write(L, string'("</testsuite>"));
        writeline(JUNIT_FILE, L);
    end procedure junit_end_testsuite;

    ----------------------------------------------------------------------------
    -- Procedure: JUnit Start Testcase
    ----------------------------------------------------------------------------
    procedure junit_start_testcase (
        variable JUNIT_FILE : in text;
        ID : in string;
        NAME : in string;
        RUNTIME : in time
    ) is
        variable L : line;
    begin
        write(L, string'("<testcase id="""));
        write(L, ID);
        write(L, string'(""" name="""));
        write(L, NAME);
        write(L, string'(""" time="""));
        write(L, junit_time(RUNTIME), right, 0, 9);
        write(L, string'(""">"));
        writeline(JUNIT_FILE, L);
    end procedure junit_start_testcase;

    ----------------------------------------------------------------------------
    -- Procedure: JUnit Testcase
    ----------------------------------------------------------------------------
    procedure junit_testcase (
        variable JUNIT_FILE : in text;
        ID : in string;
        NAME : in string;
        RUNTIME : in time
    ) is
        variable L : line;
    begin
        junit_start_testcase(JUNIT_FILE, ID, NAME, RUNTIME);
        junit_end_testcase(JUNIT_FILE);
    end procedure junit_testcase;

    ----------------------------------------------------------------------------
    -- Procedure: JUnit End Testcase
    ----------------------------------------------------------------------------
    procedure junit_end_testcase (variable JUNIT_FILE : in text) is
        variable L : line;
    begin
        write(L, string'("</testcase>"));
        writeline(JUNIT_FILE, L);
    end procedure junit_end_testcase;

    ----------------------------------------------------------------------------
    -- Procedure: JUnit Failure
    ----------------------------------------------------------------------------
    procedure junit_failure (
        variable JUNIT_FILE : in text;
        MESSAGE : in string;
        DETAIL : in string
    ) is
        variable L : line;
    begin
        write(L, string'("<failure message="""));
        write(L, MESSAGE);
        write(L, string'(""">"));
        write(L, DETAIL);
        write(L, string'("</failure>"));
        writeline(JUNIT_FILE, L);
    end procedure junit_failure;

    ----------------------------------------------------------------------------
    -- Procedure: JUnit Error
    ----------------------------------------------------------------------------
    procedure junit_error (
        variable JUNIT_FILE : in text;
        MESSAGE : in string;
        DETAIL : in string
    ) is
        variable L : line;
    begin
        write(L, string'("<error message="""));
        write(L, MESSAGE);
        write(L, string'(""">"));
        write(L, DETAIL);
        write(L, string'("</failure>"));
        writeline(JUNIT_FILE, L);
    end procedure junit_error;

    ----------------------------------------------------------------------------
    -- Procedure: JUnit Skipped
    ----------------------------------------------------------------------------
    procedure junit_skipped (
        variable JUNIT_FILE : in text
    ) is
        variable L : line;
    begin
        write(L, string'("<skipped />"));
        writeline(JUNIT_FILE, L);
    end procedure junit_skipped;

    ----------------------------------------------------------------------------
    -- Function: JUnit Time
    ----------------------------------------------------------------------------
    function junit_time (
        RUNTIME : in time
    ) return real is
    begin
        return real(RUNTIME/(1 fs)) / 1.0e15;
    end function;

end junit;