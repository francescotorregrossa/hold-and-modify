function ham = ham6(img)

s = 16;
[h, w, ~] = size(img);
ham = uint8(zeros(h, w, 3));

[ind, pal] = rgb2ind(img, s, 'nodither');
ind = ind + 1;
pal = pal * 255;
pal = uint8(uint8(pal / s) * s);

for j = 1:h

    ham(j, 1, :) = pal(ind(j, 1), :);
    for i = 2:w

        pix = img(j, i, :);
        pix = single(pix(1, :));

        hold = single(pal(ind(j, i), :));
        err_hold = norm(pix - hold, 2);

        move = ham(j, i - 1, :);
        move = single(move(1, :));

        move_r = move;
        move_g = move;
        move_b = move;
        move_r(1) = single(round(pix(1) / s) * s);
        move_g(2) = single(round(pix(2) / s) * s);
        move_b(3) = single(round(pix(3) / s) * s);

        err_r = norm(pix - move_r, 2);
        err_g = norm(pix - move_g, 2);
        err_b = norm(pix - move_b, 2);

        err = [err_hold err_r err_g err_b];
        val = reshape([hold move_r move_g move_b], [3 4])';
        [~, k] = min(err);
        ham(j, i, :) = val(k, :);

    end
end