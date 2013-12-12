class Compare
    def dHamming (s,t)
        s_string = s.chars
        t_string = t.chars
        dh = 0
        while not s_string.empty? or not t_string.empty?
            dh = dh + char_cmp(s_string.first, t_string.first)
            t_string.shift
            s_string.shift
        end 
        dh
    end

    private

    def char_cmp(cs,ct)
        cs==ct ? 0 : 1
    end
end
