insert = open("insertion.txt")
insertion_txt = insert.read
insert.close

Dir::glob("**/*.html").each{|fname|
 print fname+"\n"
 skip = false
 res = ""
 open(fname){|file|
  open(fname+".bak","w"){|dest|
   dest.write(file.read)
  }
  file.rewind
  while l = file.gets
   idx = l.index('<!-- #TemplateEndEditable -->')
   if skip && idx
    skip = false
    res += l[idx, l.length]+"\n"
   elsif skip
   elsif l.index('<!-- #TemplateBeginEditable name="unofficial translation" -->')
    skip = true
    #print insertion_txt
    res = res+insertion_txt+"\n"
   else
    #print l
    res = res+l+"\n"
   end
  end
 }
 open(fname,"w"){|t|
  t.write(res)
 }
}
