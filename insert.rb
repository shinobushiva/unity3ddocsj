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
   end_text = '<!-- #TemplateEndEditable -->'
   idx = l.index(end_text)
   if skip && idx
    skip = false
    res += l[idx+end_text.length, l.length]
   elsif skip
   elsif l.index('<!-- #TemplateBeginEditable name="unofficial translation" -->')
    skip = true
    #print insertion_txt
    res += insertion_txt+"\n"
   else
    #print l
    res += l
   end
  end
 }
 open(fname,"w"){|t|
  t.write(res)
 }
}
