.pragma library

function updatePosition(items, y) {
    var item = items.itemAt(items.curr);
    if(item.y - y >= items.diffY) {
        item.y -= items.dy;
        items.curr++;
        items.curr %= items.model;
        return true;
    }
    return false;
}

