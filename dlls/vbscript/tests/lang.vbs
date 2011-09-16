'
' Copyright 2011 Jacek Caban for CodeWeavers
'
' This library is free software; you can redistribute it and/or
' modify it under the terms of the GNU Lesser General Public
' License as published by the Free Software Foundation; either
' version 2.1 of the License, or (at your option) any later version.
'
' This library is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
' Lesser General Public License for more details.
'
' You should have received a copy of the GNU Lesser General Public
' License along with this library; if not, write to the Free Software
' Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
'

Option Explicit

dim x, y

call ok(true, "true is not true?")
ok true, "true is not true?"
call ok((true), "true is not true?")

ok not false, "not false but not true?"
ok not not true, "not not true but not true?"

Call ok(true = true, "true = true is false")
Call ok(false = false, "false = false is false")
Call ok(not (true = false), "true = false is true")
Call ok("x" = "x", """x"" = ""x"" is false")
Call ok(empty = empty, "empty = empty is false")
Call ok(empty = "", "empty = """" is false")
Call ok(0 = 0.0, "0 <> 0.0")
Call ok(16 = &h10&, "16 <> &h10&")
Call ok(010 = 10, "010 <> 10")
Call ok(10. = 10, "10. <> 10")
Call ok(&hffFFffFF& = -1, "&hffFFffFF& <> -1")
Call ok(&hffFFffFF& = -1, "&hffFFffFF& <> -1")
Call ok(--1 = 1, "--1 = " & --1)
Call ok(-empty = 0, "-empty = " & (-empty))

x = "xx"
Call ok(x = "xx", "x = " & x & " expected ""xx""")

Call ok(true <> false, "true <> false is false")
Call ok(not (true <> true), "true <> true is true")
Call ok(not ("x" <> "x"), """x"" <> ""x"" is true")
Call ok(not (empty <> empty), "empty <> empty is true")
Call ok(x <> "x", "x = ""x""")

Call ok(getVT(false) = "VT_BOOL", "getVT(false) is not VT_BOOL")
Call ok(getVT(true) = "VT_BOOL", "getVT(true) is not VT_BOOL")
Call ok(getVT("") = "VT_BSTR", "getVT("""") is not VT_BSTR")
Call ok(getVT("test") = "VT_BSTR", "getVT(""test"") is not VT_BSTR")
Call ok(getVT(Empty) = "VT_EMPTY", "getVT(Empty) is not VT_EMPTY")
Call ok(getVT(null) = "VT_NULL", "getVT(null) is not VT_NULL")
Call ok(getVT(0) = "VT_I2", "getVT(0) is not VT_I2")
Call ok(getVT(1) = "VT_I2", "getVT(1) is not VT_I2")
Call ok(getVT(0.5) = "VT_R8", "getVT(0.5) is not VT_R8")
Call ok(getVT(0.0) = "VT_R8", "getVT(0.0) is not VT_R8")
Call ok(getVT(2147483647) = "VT_I4", "getVT(2147483647) is not VT_I4")
Call ok(getVT(2147483648) = "VT_R8", "getVT(2147483648) is not VT_R8")
Call ok(getVT(&h10&) = "VT_I2", "getVT(&h10&) is not VT_I2")
Call ok(getVT(&h10000&) = "VT_I4", "getVT(&h10000&) is not VT_I4")
Call ok(getVT(&H10000&) = "VT_I4", "getVT(&H10000&) is not VT_I4")
Call ok(getVT(&hffFFffFF&) = "VT_I2", "getVT(&hffFFffFF&) is not VT_I2")
Call ok(getVT(1 & 100000) = "VT_BSTR", "getVT(1 & 100000) is not VT_BSTR")
Call ok(getVT(-empty) = "VT_I2", "getVT(-empty) = " & getVT(-empty))
Call ok(getVT(-null) = "VT_NULL", "getVT(-null) = " & getVT(-null))
Call ok(getVT(y) = "VT_EMPTY*", "getVT(y) = " & getVT(y))
Call ok(getVT(nothing) = "VT_DISPATCH", "getVT(nothing) = " & getVT(nothing))
set x = nothing
Call ok(getVT(x) = "VT_DISPATCH*", "getVT(x=nothing) = " & getVT(x))
x = true
Call ok(getVT(x) = "VT_BOOL*", "getVT(x) = " & getVT(x))

Call ok(isNullDisp(nothing), "nothing is not nulldisp?")

x = "xx"
Call ok("ab" & "cd" = "abcd", """ab"" & ""cd"" <> ""abcd""")
Call ok("ab " & null = "ab ", """ab"" & null = " & ("ab " & null))
Call ok("ab " & empty = "ab ", """ab"" & empty = " & ("ab " & empty))
Call ok(1 & 100000 = "1100000", "1 & 100000 = " & (1 & 100000))
Call ok("ab" & x = "abxx", """ab"" & x = " & ("ab"&x))

if(isEnglishLang) then
    Call ok("" & true = "True", """"" & true = " & true)
    Call ok(true & false = "TrueFalse", "true & false = " & (true & false))
end if

call ok(true and true, "true and true is not true")
call ok(true and not false, "true and not false is not true")
call ok(not (false and true), "not (false and true) is not true")
call ok(getVT(null and true) = "VT_NULL", "getVT(null and true) = " & getVT(null and true))

call ok(false or true, "false or uie is false?")
call ok(not (false or false), "false or false is not false?")
call ok(false and false or true, "false and false or true is false?")
call ok(true or false and false, "true or false and false is false?")
call ok(null or true, "null or true is false")

call ok(true xor false, "true xor false is false?")
call ok(not (false xor false), "false xor false is true?")
call ok(not (true or false xor true), "true or false xor true is true?")
call ok(not (true xor false or true), "true xor false or true is true?")

call ok(false eqv false, "false does not equal false?")
call ok(not (false eqv true), "false equals true?")
call ok(getVT(false eqv null) = "VT_NULL", "getVT(false eqv null) = " & getVT(false eqv null))

call ok(true imp true, "true does not imp true?")
call ok(false imp false, "false does not imp false?")
call ok(not (true imp false), "true imp false?")
call ok(false imp null, "false imp null is false?")

x = 3
Call ok(2+2 = 4, "2+2 = " & (2+2))
Call ok(false + 6 + true = 5, "false + 6 + true <> 5")
Call ok(getVT(2+null) = "VT_NULL", "getVT(2+null) = " & getVT(2+null))
Call ok(2+empty = 2, "2+empty = " & (2+empty))
Call ok(x+x = 6, "x+x = " & (x+x))

Call ok(5-1 = 4, "5-1 = " & (5-1))
Call ok(3+5-true = 9, "3+5-true <> 9")
Call ok(getVT(2-null) = "VT_NULL", "getVT(2-null) = " & getVT(2-null))
Call ok(2-empty = 2, "2-empty = " & (2-empty))
Call ok(2-x = -1, "2-x = " & (2-x))

Call ok(9 Mod 6 = 3, "9 Mod 6 = " & (9 Mod 6))
Call ok(11.6 Mod 5.5 = False, "11.6 Mod 5.5 = " & (11.6 Mod 5.5 = 0.6))
Call ok(7 Mod 4+2 = 5, "7 Mod 4+2 <> 5")
Call ok(getVT(2 mod null) = "VT_NULL", "getVT(2 mod null) = " & getVT(2 mod null))
Call ok(getVT(null mod 2) = "VT_NULL", "getVT(null mod 2) = " & getVT(null mod 2))
'FIXME: Call ok(empty mod 2 = 0, "empty mod 2 = " & (empty mod 2))

Call ok(5 \ 2 = 2, "5 \ 2 = " & (5\2))
Call ok(4.6 \ 1.5 = 2, "4.6 \ 1.5 = " & (4.6\1.5))
Call ok(4.6 \ 1.49 = 5, "4.6 \ 1.49 = " & (4.6\1.49))
Call ok(2+3\4 = 2, "2+3\4 = " & (2+3\4))

Call ok(2*3 = 6, "2*3 = " & (2*3))
Call ok(3/2 = 1.5, "3/2 = " & (3/2))
Call ok(5\4/2 = 2, "5\4/2 = " & (5\2/1))
Call ok(12/3\2 = 2, "12/3\2 = " & (12/3\2))

Call ok(2^3 = 8, "2^3 = " & (2^3))
Call ok(2^3^2 = 64, "2^3^2 = " & (2^3^2))
Call ok(-3^2 = 9, "-3^2 = " & (-3^2))
Call ok(2*3^2 = 18, "2*3^2 = " & (2*3^2))

if false then
    ok false, "if false called"
end if

x = true
if x then
    x = false
end if
Call ok(not x, "x is false, if not evaluated?")

x = false
If false Then
   Call ok(false, "inside if false")
Else
   x = true
End If
Call ok(x, "else not called?")

x = false
If false Then
   Call ok(false, "inside if false")
ElseIf not True Then
   Call ok(false, "inside elseif not true")
Else
   x = true
End If
Call ok(x, "else not called?")

x = false
If false Then
   Call ok(false, "inside if false")
   x = 1
   y = 10+x
ElseIf not False Then
   x = true
Else
   Call ok(false, "inside else not true")
End If
Call ok(x, "elseif not called?")

x = false
If false Then
   Call ok(false, "inside if false")
ElseIf not False Then
   x = true
End If
Call ok(x, "elseif not called?")

x = false
y = false
while not (x and y)
    if x then
        y = true
    end if
    x = true
wend
call ok((x and y), "x or y is false after while")

while false
wend

x = false
y = false
do while not (x and y)
    if x then
        y = true
    end if
    x = true
loop
call ok((x and y), "x or y is false after while")

do while false
loop

do while true
    exit do
    ok false, "exit do didn't work"
loop

if false then
Sub testsub
    x = true
End Sub
end if

x = false
Call testsub
Call ok(x, "x is false, testsub not called?")

Sub SubSetTrue(v)
    Call ok(not v, "v is not true")
    v = true
End Sub

x = false
SubSetTrue x
Call ok(x, "x was not set by SubSetTrue")

SubSetTrue false
Call ok(not false, "false is no longer false?")

Sub SubSetTrue2(ByRef v)
    Call ok(not v, "v is not true")
    v = true
End Sub

x = false
SubSetTrue2 x
Call ok(x, "x was not set by SubSetTrue")

Sub TestSubArgVal(ByVal v)
    Call ok(not v, "v is not false")
    v = true
    Call ok(v, "v is not true?")
End Sub

x = false
Call TestSubArgVal(x)
Call ok(not x, "x is true after TestSubArgVal call?")

Sub TestSubMultiArgs(a,b,c,d,e)
    Call ok(a=1, "a = " & a)
    Call ok(b=2, "b = " & b)
    Call ok(c=3, "c = " & c)
    Call ok(d=4, "d = " & d)
    Call ok(e=5, "e = " & e)
End Sub

Sub TestSubExit(ByRef a)
    If a Then
        Exit Sub
    End If
    Call ok(false, "Exit Sub not called?")
End Sub

Call TestSubExit(true)

TestSubMultiArgs 1, 2, 3, 4, 5
Call TestSubMultiArgs(1, 2, 3, 4, 5)

Sub TestSubLocalVal
    x = false
    Call ok(not x, "local x is not false?")
    Dim x
End Sub

x = true
y = true
Call TestSubLocalVal
Call ok(x, "global x is not true?")

Public Sub TestPublicSub
End Sub
Call TestPublicSub

Private Sub TestPrivateSub
End Sub
Call TestPrivateSub

if false then
Function testfunc
    x = true
End Function
end if

x = false
Call TestFunc
Call ok(x, "x is false, testfunc not called?")

Function FuncSetTrue(v)
    Call ok(not v, "v is not true")
    v = true
End Function

x = false
FuncSetTrue x
Call ok(x, "x was not set by FuncSetTrue")

FuncSetTrue false
Call ok(not false, "false is no longer false?")

Function FuncSetTrue2(ByRef v)
    Call ok(not v, "v is not true")
    v = true
End Function

x = false
FuncSetTrue2 x
Call ok(x, "x was not set by FuncSetTrue")

Function TestFuncArgVal(ByVal v)
    Call ok(not v, "v is not false")
    v = true
    Call ok(v, "v is not true?")
End Function

x = false
Call TestFuncArgVal(x)
Call ok(not x, "x is true after TestFuncArgVal call?")

Function TestFuncMultiArgs(a,b,c,d,e)
    Call ok(a=1, "a = " & a)
    Call ok(b=2, "b = " & b)
    Call ok(c=3, "c = " & c)
    Call ok(d=4, "d = " & d)
    Call ok(e=5, "e = " & e)
End Function

TestFuncMultiArgs 1, 2, 3, 4, 5
Call TestFuncMultiArgs(1, 2, 3, 4, 5)

Function TestFuncLocalVal
    x = false
    Call ok(not x, "local x is not false?")
    Dim x
End Function

x = true
y = true
Call TestFuncLocalVal
Call ok(x, "global x is not true?")

Function TestFuncExit(ByRef a)
    If a Then
        Exit Function
    End If
    Call ok(false, "Exit Function not called?")
End Function

Call TestFuncExit(true)

Function ReturnTrue
     ReturnTrue = false
     ReturnTrue = true
End Function

Call ok(ReturnTrue(), "ReturnTrue returned false?")

Function SetVal(ByRef x, ByVal v)
    x = v
    SetVal = x
    Exit Function
End Function

x = false
ok SetVal(x, true), "SetVal returned false?"
Call ok(x, "x is not set to true by SetVal?")

Public Function TestPublicFunc
End Function
Call TestPublicFunc

Private Function TestPrivateFunc
End Function
Call TestPrivateFunc

' Stop has an effect only in debugging mode
Stop

set x = testObj
Call ok(getVT(x) = "VT_DISPATCH*", "getVT(x=testObj) = " & getVT(x))

Dim obj
Set obj = New EmptyClass
Call ok(getVT(obj) = "VT_DISPATCH*", "getVT(obj) = " & getVT(obj))

Class EmptyClass
End Class

Class TestClass
    Public publicProp

    Private privateProp

    Public Function publicFunction()
        privateSub()
        publicFunction = 4
    End Function

    Public Property Get gsProp()
        gsProp = privateProp
        funcCalled = "gsProp get"
        exit property
        Call ok(false, "exit property not returned?")
    End Property

    Public Default Property Get DefValGet
        DefValGet = privateProp
        funcCalled = "GetDefVal"
    End Property

    Public Property Let DefValGet(x)
    End Property

    Public publicProp2

    Public Sub publicSub
    End Sub

    Public Property Let gsProp(val)
        privateProp = val
        funcCalled = "gsProp let"
        exit property
        Call ok(false, "exit property not returned?")
    End Property

    Public Property Set gsProp(val)
        funcCalled = "gsProp set"
        exit property
        Call ok(false, "exit property not returned?")
    End Property

    Public Sub setPrivateProp(x)
        privateProp = x
    End Sub

    Function getPrivateProp
        getPrivateProp = privateProp
    End Function

    Private Sub privateSub
    End Sub

    Public Sub Class_Initialize
        publicProp2 = 2
        privateProp = true
    End Sub
End Class

Call testDisp(new testClass)

Set obj = New TestClass

Call ok(obj.publicFunction = 4, "obj.publicFunction = " & obj.publicFunction)
Call ok(obj.publicFunction() = 4, "obj.publicFunction() = " & obj.publicFunction())

obj.publicSub()
Call obj.publicSub
Call obj.publicFunction()

Call ok(getVT(obj.publicProp) = "VT_EMPTY", "getVT(obj.publicProp) = " & getVT(obj.publicProp))
obj.publicProp = 3
Call ok(obj.publicProp = 3, "obj.publicProp = " & obj.publicProp)
obj.publicProp() = 3

Call ok(obj.getPrivateProp() = true, "obj.getPrivateProp() = " & obj.getPrivateProp())
Call obj.setPrivateProp(6)
Call ok(obj.getPrivateProp = 6, "obj.getPrivateProp = " & obj.getPrivateProp)

Dim funcCalled
funcCalled = ""
Call ok(obj.gsProp = 6, "obj.gsProp = " & obj.gsProp)
Call ok(funcCalled = "gsProp get", "funcCalled = " & funcCalled)
obj.gsProp = 3
Call ok(funcCalled = "gsProp let", "funcCalled = " & funcCalled)
Call ok(obj.getPrivateProp = 3, "obj.getPrivateProp = " & obj.getPrivateProp)
Set obj.gsProp = New testclass
Call ok(funcCalled = "gsProp set", "funcCalled = " & funcCalled)

x = obj
Call ok(x = 3, "(x = obj) = " & x)
Call ok(funcCalled = "GetDefVal", "funcCalled = " & funcCalled)
funcCalled = ""
Call ok(obj = 3, "(x = obj) = " & obj)
Call ok(funcCalled = "GetDefVal", "funcCalled = " & funcCalled)

Call obj.Class_Initialize
Call ok(obj.getPrivateProp() = true, "obj.getPrivateProp() = " & obj.getPrivateProp())

x = (New testclass).publicProp

Class TermTest
    Public Sub Class_Terminate()
        funcCalled = "terminate"
    End Sub
End Class

Set obj = New TermTest
funcCalled = ""
Set obj = Nothing
Call ok(funcCalled = "terminate", "funcCalled = " & funcCalled)

Set obj = New TermTest
funcCalled = ""
Call obj.Class_Terminate
Call ok(funcCalled = "terminate", "funcCalled = " & funcCalled)
funcCalled = ""
Set obj = Nothing
Call ok(funcCalled = "terminate", "funcCalled = " & funcCalled)

reportSuccess()