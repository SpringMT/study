#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-


require 'pp'
def sort_by_name(users=[])
    origin = "ａ-ｚＡ-Ｚァ-ン０-９ぁぃぅぇぉがぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽゃゅょっゎァィゥェォガギグゲゴザジズゼゾダヂヅデドバビブベボパピプペポャュョッヮ"
    normalize = "a-zA-Zぁ-ん0-9あいうえおかきくけこさしすせそたちつてとはひふへほはひふへほやゆよつわあいうえおかきくけこさしすせそたちつてとはひふへほはひふへほやゆよつわ"

    users.sort_by{|a| [a.tr(origin, normaliz), a.tr(origin, normalize)]}
end


users = ['いいい', 'ああ あ', 'あ い', 'ううう']
pp users.sort{|a, b| a <=> b}
# sort_by_name(users)
