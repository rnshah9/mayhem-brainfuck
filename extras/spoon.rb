#!/usr/bin/ruby
eval 'm=Hash.new(p=0);'+ARGF.read.gsub(/[^01]/,'').gsub(
	/1|000|010|011|0011|00100|001010|0010110|00101110|00101111/,
        '1' => 'm[p]+=1;',
        '000' => 'm[p]-=1;',
        '010' => 'p+=1;',
        '011' => 'p-=1;',
        '0011' => ')while(m[p]!=0);',
        '00100' => '(',
        '001010' => 'putc m[p];',
        '0010110' => 'm[p]=STDIN.getbyte if !STDIN.eof;'
        )
