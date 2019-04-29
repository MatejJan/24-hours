function print_deep(o,d)
  if d==nil then d=1 end
  local t=type(o)
  if t=="table" and d>0 then
    for k,v in pairs(o) do
      if k and v then
        local line="xx"
        if type(k)=="table" then
          line="[table]="
        else
          line=k.."="
        end
        if type(v)=="table" and v.print then
          printh(line)
          v.print()
        else
          if d==1 then
            local tv=type(v)
            if tv=="table" then
              printh(line.."table")
            elseif tv=="function" then
              printh(line.."function")
            elseif tv=="boolean" then
              if tv then
                printh(line.."true")
              else
                printh(line.."false")
              end
            else
              printh(line..v)
            end
          else
            printh(line)
            print_deep(v,d-1)
          end
        end
      else
        printh(k.."=nil")
      end
    end
  else
    printh(o)
  end
end
