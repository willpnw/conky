home=true

start=180
end1=0
end2=360

bg_c=0xffffff
bg_a=0.5
fg_c=0x1066FF
fg_a=0.8
acc=0xFF6600

rClk=100
thickClk=rClk/18
xClk=140
yClk=140

x0=xClk+rClk

if home then
    rad=70
    y0=220
    x1=x0 + 1100
    thick=rad/12
else
    rad=80
    y0=270
    x1=x0 + 1550
    thick=rad/7
end


y1=y0

yOffset=2*rad

xSwap=x1
ySwap=y1

xRam=x1
yRam=ySwap+yOffset

xStorage=x1
yStorage=yRam+yOffset

xStorage2=x1
yStorage2=yStorage+yOffset

xCpu1=x1
xCpu2=x1
xCpu3=x1
xCpu4=x1

yCpu1=yStorage2+yOffset
yCpu2=yCpu1
yCpu3=yCpu1
yCpu4=yCpu1

cpu1Start=0
cpu2Start=90
cpu3Start=180
cpu4Start=270

cpu1End=90
cpu2End=180
cpu3End=270
cpu4End=360

coreUse=0
settings_table = {
    {
        name='time',
        display='',
        max=12,
        bg_colour=0xffffff,
        bg_alpha=bg_a,
        fg_colour=acc,
        fg_alpha=0.8,
        x=xClk, y=yClk,
        radius=rClk*0.6,
        thickness=thickClk,
        start_angle=0,
        end_angle=360
    },
    {
        name='time',
        arg='%M.%S', --minutes
        display='',
        max=60,
        bg_colour=0xffffff,
        bg_alpha=bg_a,
        fg_colour=0x10FF66,
        fg_alpha=0.8,
        x=xClk, y=yClk,
        radius=rClk*0.7,
        thickness=thickClk,
        start_angle=0,
        end_angle=360
    },
    {
        name='time',
        arg='%S', --seconds
        display='',
        max=60,
        bg_colour=0xffffff,
        bg_alpha=bg_a,
        fg_colour=0x1066FF,
        fg_alpha=0.6,
        x=xClk, y=yClk,
        radius=rClk*0.8,
        thickness=thickClk,
        start_angle=0,
        end_angle=360
    },
    {
        name='time',
        arg='%d',
        display='',
        max=31,
        bg_colour=0xffffff,
        bg_alpha=bg_a,
        fg_colour=0x1066FF,
        fg_alpha=0.8,
        x=xClk, y=yClk,
        radius=rClk*0.9,
        thickness=thickClk,
        start_angle=-90,
        end_angle=90
    },
    {
        name='time',
        arg='%m',
        display='',
        max=12,
        bg_colour=0xffffff,
        bg_alpha=bg_a,
        fg_colour=0x1066FF,
        fg_alpha=1,
        x=xClk, y=yClk,
        radius=rClk,
        thickness=thickClk,
        start_angle=-90,
        end_angle=90
    },
    {
        name='fs_used_perc',
        arg='/home/will',
        display='WILL',
        max=100,
        bg_colour=bg_c,
        bg_alpha=bg_a,
        fg_colour=fg_c,
        fg_alpha=fg_a,
        x=xStorage2, y=yStorage2,
        radius=rad,
        thickness=thick,
        start_angle=start,
        end_angle=end2
    },
    {
        name='fs_used_perc',
        arg='',
        display='DISK',
        max=100,
        bg_colour=bg_c,
        bg_alpha=bg_a,
        fg_colour=fg_c,
        fg_alpha=fg_a,
        x=xStorage, y=yStorage,
        radius=rad,
        thickness=thick,
        start_angle=start,
        end_angle=end1
    },
    {
        name='swapperc',
        arg='',
        display='SWAP',
        max=100,
        bg_colour=bg_c,
        bg_alpha=bg_a,
        fg_colour=fg_c,
        fg_alpha=fg_a,
        x=xSwap, y=ySwap,
        radius=rad,
        thickness=thick,
        start_angle=start,
        end_angle=end1
    },
    {
        name='memperc',
        arg='',
        display='MEMORY',
        max=100,
        bg_colour=bg_c,
        bg_alpha=bg_a,
        fg_colour=fg_c,
        fg_alpha=fg_a,
        x=xRam, y=yRam,
        radius=rad,
        thickness=thick,
        start_angle=start,
        end_angle=end2
    },
    {
        name='cpu',
        arg='cpu0',
        display='',
        max=100,
        bg_colour=bg_c,
        bg_alpha=bg_a,
        fg_colour=fg_c,
        fg_alpha=fg_a,
        x=xCpu1, y=yCpu1,
        radius=rad,
        thickness=thick,
        start_angle=cpu1Start,
        end_angle=cpu1End
    },
    {
        name='cpu',
        arg='cpu1',
        display='',
        max=100,
        bg_colour=bg_c,
        bg_alpha=bg_a,
        fg_colour=fg_c,
        fg_alpha=fg_a,
        x=xCpu2, y=yCpu2,
        radius=rad,
        thickness=thick,
        start_angle=cpu2Start,
        end_angle=cpu2End
    },
    {
        name='cpu',
        arg='cpu2',
        display='',
        max=100,
        bg_colour=bg_c,
        bg_alpha=bg_a,
        fg_colour=fg_c,
        fg_alpha=fg_a,
        x=xCpu3, y=yCpu3,
        radius=rad,
        thickness=thick,
        start_angle=cpu3Start,
        end_angle=cpu3End
    },
    {
        name='cpu',
        arg='cpu3',
        display='',
        max=100,
        bg_colour=bg_c,
        bg_alpha=bg_a,
        fg_colour=fg_c,
        fg_alpha=fg_a,
        x=xCpu4, y=yCpu4,
        radius=rad,
        thickness=thick,
        start_angle=cpu4Start,
        end_angle=cpu4End
    },
}

show_seconds=true

require 'cairo'

function rgb_to_r_g_b(colour,alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function print_top(cr)
    local bga    = 1

    print_str(cr, "NAME", 20,  700, 12, bg_c, bga)
    print_str(cr, "PID",  100, 700, 12, bg_c, bga)
    print_str(cr, "MEM%", 150, 700, 12, bg_c, bga)
    print_str(cr, "CPU%", 200, 700, 12, bg_c, bga)

    for i = 1, 10, 1 do

        local y    = 700 + i * 15
        local name = conky_parse(string.format('${top name %d}',i))
        local pid  = conky_parse(string.format('${top pid %d}',i))
        local mem  = conky_parse(string.format('${top mem %d}',i))
        local cpu  = conky_parse(string.format('${top cpu %d}',i))
        print_str(cr, name, 20, y,  9, bg_c, bga)
        print_str(cr, pid, 100, y,  9, bg_c, bga)
        print_str(cr, mem, 150, y,  9, bg_c, bga)
        print_str(cr, cpu, 200, y,  9, bg_c, bga)
    end
end

function print_stats(cr)
    local ip   = conky_parse('${addr wlp3s0}')
    local bga    = 1
    print_str(cr, ip, 260, 130,  16,  0x10FF66, bga)
end

function print_date_time(cr)
    local bgc    = bg_c
    local bga    = 1
    local day    = conky_parse('${time %A}')
    local month  = conky_parse('${time %b}')
    local date   = conky_parse('${time %e}')
    local year   = conky_parse('${time %Y}')
    local hour   = conky_parse('${time %l}')
    local minute = conky_parse('${time %M}')

    if home then
        x_time   = 580
        x_day    = x_time + 500
    else
        x_time   = 800
        x_day    = x_time + 750
    end

    x_month  = x_day
    x_date   = x_day + 120

    if home then
        y_time   = y0 - 90
        y_day    = y_time - 60
        y_month  = y0 - 100
    else
        y_time   = y0 - 100
        y_day    = y_time - 60
        y_month  = y0 - 110
    end

    y_date   = y_month

    font_time   = 150
    font_day    = 55
    font_month  = 55
    font_date   = 55

    time_str = string.format('%s:%s',hour,minute)
    print_str(cr, time_str, x_time,  y_time,  font_time,  bgc,      bga)
    print_str(cr, day,    x_day,    y_day,    font_day,    acc, 1)
    print_str(cr, month,  x_month,  y_month,  font_month,  bgc,      bga)
    print_str(cr, date,   x_date,   y_date,   font_date,   fg_c,     1)
end

function print_str(cr, text, xpos, ypos, font_size, bgc, bga)

    local font="comfortaa"
    local red,green,blue,alpha=1,1,1,1
    local font_slant=CAIRO_FONT_SLANT_NORMAL
    local font_face=CAIRO_FONT_WEIGHT_BOLD

    cairo_select_font_face (cr, font, font_slant, font_face);
    cairo_set_font_size (cr, font_size)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
    cairo_move_to (cr,xpos,ypos)
    cairo_show_text (cr,text)
    cairo_stroke (cr)
end

function draw_ring(cr,t,pt, core)
    local w,h=conky_window.width,conky_window.height

    local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
    local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

    local angle_0=sa*(2*math.pi/360)-math.pi/2
    local angle_f=ea*(2*math.pi/360)-math.pi/2
    local t_arc=t*(angle_f-angle_0)

    if core then
        if(t < .25) then
            fgc=fg_c
        elseif(t < .5) then
            fgc=0xffff00
        elseif(t < .75) then
            fgc=acc
        else
            fgc=0xff0000
        end

    end

    -- Draw background ring

    if sa < ea then
        cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
    else
        cairo_arc_negative(cr,xc,yc,ring_r,angle_0,angle_f)
    end

    cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND)

    cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
    cairo_set_line_width(cr,ring_w)
    cairo_stroke(cr)
    cairo_set_line_width(cr,ring_w*1.5)

    -- Draw indicator ring
    if sa < ea then
        cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
    else
        cairo_arc_negative(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
    end

    cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
    cairo_stroke(cr)
end

function draw_hr(cr)
    local y = y1 - rad
    cairo_move_to(cr,x0,y)
    cairo_line_to(cr,x1,y)

    cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND)
    cairo_set_line_width(cr,thick)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(bg_c,bg_a))
    cairo_stroke(cr)
end

function draw_clock_hands(cr)
    local secs,mins,hours,secs_arc,mins_arc,hours_arc
    local xh,yh,xm,ym,xs,ys

    secs=os.date("%S")
    mins=os.date("%M")
    hours=os.date("%I")

    secs_arc=(2*math.pi/60)*secs
    mins_arc=(2*math.pi/60)*mins+secs_arc/60
    hours_arc=(2*math.pi/12)*hours+mins_arc/12

    -- Draw hour hand

    xh=xClk+0.6*rClk*math.sin(hours_arc)
    yh=yClk-0.6*rClk*math.cos(hours_arc)
    cairo_move_to(cr,xClk,yClk)
    cairo_line_to(cr,xh,yh)

    cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND)
    cairo_set_line_width(cr,5)
    cairo_set_source_rgba(cr,1.0,1.0,1.0,1.0)
    cairo_stroke(cr)

    -- Draw minute hand

    xm=xClk+0.7*rClk*math.sin(mins_arc)
    ym=yClk-0.7*rClk*math.cos(mins_arc)
    cairo_move_to(cr,xClk,yClk)
    cairo_line_to(cr,xm,ym)

    cairo_set_line_width(cr,3)
    cairo_stroke(cr)

    -- Draw seconds hand

    if show_seconds then
        xs=xClk+0.8*rClk*math.sin(secs_arc)
        ys=yClk-0.8*rClk*math.cos(secs_arc)
        cairo_move_to(cr,xClk,yClk)
        cairo_line_to(cr,xs,ys)

        cairo_set_line_width(cr,1)
        cairo_stroke(cr)
    end
end

function conky_clock_rings()
    local function setup_rings(cr,i)
        local str=''
        local value=0
        pt = settings_table[i]

        if(i == 1) then
            local hour   = tonumber(conky_parse('${time %l}'))
            local minute = tonumber(conky_parse('${time %M}'))
            if hour == 12 then
                hour = 0
            end
            value = hour +(minute/60)
        else
            str=string.format('${%s %s}',pt['name'],pt['arg'])
            str=conky_parse(str)
            value=tonumber(str)
        end


        local core = (i > 9)

        if value then
            pct=value/pt['max']
            draw_ring(cr,pct,pt,core)
        end

        local xc,yc,display=pt['x'],pt['y'],pt['display']
        if (display ~= "") then
            print_str(cr, display, xc, yc, 15, bg_c, 1)
            print_str(cr, pct*100 .. '%', xc, yc+20, 16, bg_c, 1)
        end

        if(i < 10) then
            coreUse=0
        else
            coreUse=coreUse + pct
        end

        if(i == 13) then
            coreUse=math.floor(coreUse*100/4+0.5)
            print_str(cr, "CORES", xc, yc, 14, bg_c, fg_a)
            print_str(cr, coreUse .. '%', xc, yc+20, 14, bg_c, fg_a)
        end

    end

    -- Check that Conky has been running for at least 5s

    if conky_window==nil then return end
    local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)

    local cr=cairo_create(cs)

    local updates=conky_parse('${updates}')
    update_num=tonumber(updates)

    if update_num>5 then
        for i in pairs(settings_table) do
            setup_rings(cr,i)
        end
    end

    --draw_clock_hands(cr)
    draw_hr(cr)
    print_date_time(cr)
    print_stats(cr)
    print_top(cr)
end
