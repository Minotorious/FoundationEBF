---@diagnostic disable: lowercase-global
--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |               GLOBAL UTILITY FUNCTIONS               | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\--------------------------------------------------------------------------]]--

local EBF = ...

--[[----------------------------- UTILITY FUNCTIONS ---------------------------]]--

function starts_with(str, start)
   return str:sub(1, #start) == start
end

function contains(str, subStr)
   return str:find(subStr, 1, true) ~= nil
end

function ends_with(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end

function rotateVector(v, q)
   q = quaternion.conjugate(q)
   local u = { q.x, q.y, q.z }
   local s = q.w

   -- 2.0f * dot(u, v) * u
   local dotUV = 2*(u[1]*v[1] + u[2]*v[2] + u[3]*v[3])
   local term1 = { dotUV*u[1], dotUV*u[2], dotUV*u[3] }

   -- (s*s - dot(u, u)) * v
   local dotUU = s*s - (u[1]*u[1] + u[2]*u[2] + u[3]*u[3])
   local term2 = { dotUU*v[1], dotUU*v[2], dotUU*v[3] }

   -- 2.0f * s * cross(u, v)
   local crossUV = { u[2]*v[3] - u[3]*v[2], u[3]*v[1] - u[1]*v[3], u[1]*v[2] - u[2]*v[1] } 
   local term3 = { 2*s*crossUV[1], 2*s*crossUV[2], 2*s*crossUV[3] } 

   local rotatedVector = { term1[1] + term2[1] + term3[1], term1[2] + term2[2] + term3[2], term1[3] + term2[3] + term3[3] }

   return rotatedVector
end
