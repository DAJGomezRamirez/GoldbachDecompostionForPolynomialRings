-- Authors: Alberto F. Boix, and Danny A. J. Gómez Ramírez.

-- Email addresses: alberto.fernandez.boix@uva.es (A. F. Boix), danny.gomez@pascualbravo.edu.co (D. A. J. Gómez Ramírez).

-- Funding: A. F. Boix is currently partially supported by PID2019-104844GB-I00.

-- It is worth mentioning that this package is still being tested.

-- So, please report any bug to any of the previous e-mail addresses.

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
--  This program is free software; you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation; either version 2 of the License, or (at
--  your option) any later version.
--
--  This program is distributed in the hope that it will be useful, but
--  WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
--  General Public License for more details.
--
--  You should have received a copy of the GNU General Public License along
--  with this program; if not, write to the Free Software Foundation, Inc.,
--  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
--
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


-----------------------------------------------------------

sproduct=method();

-- Input: list L of non--negative integers.

-- Output: the product of all its non--zero entries.

sproduct(List):=(L)->(
local j;
local m;
local answer;
local p;
m=#L;
j=0;
answer=1;
while (j<m) do
{
p=L_j;
if (p>0) then answer=answer*p;
j=j+1;
};
answer
);

wexponent=method();

-- Input: list L of non--negative integers.

-- Output: the list w representing the exponent set of the monomial

-- constructed to obtain an absolutely irreducible polynomial.

wexponent(List):=(L)->(
local j;
local m;
local u;
local v;
local i;
local g;
m=#L;
answer={};
if (m==2) then
{
    j=0;
    if (L_j>0) then
    {
        answer=append(answer,L_j);
        u=L_j;
        j=j+1;
        v=L_j;
        u=u+1;
        v=v+1;
        answer=append(answer,u^v);
    }
    else
    {
        j=j+1;
        if (L_j>0) then
        {
            u=L_j;
            answer=append(answer,u+1);
            answer=append(answer,u);
        }
        else
        {
            answer=join(answer,{1,0});
        };
    };
    return answer;
}
else
{
    j=0;
    v=sproduct(L);
    while (j<m) do
    {
        u=L_j;
        if (u>0) then
        {
            if (j==0) then
            {
                answer=append(answer,2*u);
                answer=append(answer,v+2);
                answer=append(answer,v+3);
                if (m>3) then
                {
                    for i to m-4 do
                    {
                        answer=append(answer,0);
                    };
                };
                return answer;
            }
            else
            {
                if (j==1) then
                {
                    answer=append(answer,v+2);
                    answer=append(answer,2*u);
                    answer=append(answer,v+3);
                    if (m>3) then
                    {
                        for i to m-4 do
                        {
                        answer=append(answer,0);
                        };
                    };
                    return answer;
                }
                else
                {
                    if (j==2) then
                    {
                        answer=append(answer,v+2);
                        answer=append(answer,v+3);
                        answer=append(answer,2*u);
                        if (m>3) then
                        {
                            for i to m-4 do
                            {
                                answer=append(answer,0);
                            };
                        };
                        return answer;
                    }
                    else
                    {
                        answer=append(answer,v+2);
                        answer=append(answer,v+3);
                        for i to j-3 do
                        {
                            answer=append(answer,0);
                        };
                        answer=append(answer,2*u);
                        for i from j+1 to m-1 do
                        {
                            answer=append(answer,0);
                        };
                        return answer;
                    };
                };
            };
        }
        else
        {
            j=j+1;
        };

    };
};
if (answer=={}) then
{
    g={};
    g=append(g,1);
    for i from 1 to m-1 do
    {
        g=append(g,0);
    };
    answer=join(answer,g);
};
answer
);

explicitirreducible=method();

-- Input: polynomial f inside a polynomial ring of n variables.

-- Output: two matrices, the first one contains the exponent set

-- of the monomials of our polynomial f.

-- The second one contain the w's constructed along the proof of the

-- main theorem of our paper

explicitirreducible(RingElement):=(f)->(
local h;
local g;
local i;
local answer;
local l;
local m;
local s;
local r;
local p;
local t;
local box;
local cup;
local c;
local d;
R:=ring(f);
c=coefficient(1_R,f);
r=first entries vars(R);
n:=rank source vars(R);
g=exponents(f);
l=first entries first(coefficients(f));
print("The monomials of");
print(" ");
print(f);
print(" ");
print("are");
print(" ");
print(l);
print(" ");
print("The exponent set of");
print(" ");
print(f);
print(" ");
print("is");
print(" ");
print(matrix(g));
m=#g;
answer=apply(g,h->wexponent(h));
print(" ");
print("The w points are");
print(" ");
print(matrix(answer));
box={};
apply(answer,t->
{
    p=1;
    for i from 0 to n-1 do
    {
        s=t_i;
        p=p*(r_i)^s;
    };
    box=append(box,p);
});
print(" ");
print("The corresponding monomials given by the w points are");
print(" ");
print(box);
print(" ");
cup={};
for i from 0 to length(box)-2 do
{
    cup=append(cup,(box_i)+1);
};
d=length(box)-1;
if (c==0) then
{
    cup=append(cup,(box_d)+1);
}
else
{
    cup=append(cup,(box_d)+c);
};
print("The corresponding absolutely irreducible polynomials are");
print(" ");
print(cup);
print(" ");
print("and also");
print(" ");
print(l+cup);
);
