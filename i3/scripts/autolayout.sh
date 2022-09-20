#!/usr/bin/python3

from i3ipc import Connection

def move_con(con, d):
    if d < 0:
        direction = 'left'
        d = -d
    else:
        direction = 'right'
    while d > 0:
        con.command('move {}'.format(direction))
        d = d - 1

def place_node(cnx, con, new_con):
    if con.layout == 'splith' and len(con.nodes) == 1 and \
            con.nodes[0].layout == 'splith':
        return place_node(cnx, con.nodes[0], new_con)
    elif con.layout != 'splith' or len(con.nodes) < 3:
        return

    child = None
    for i in range(len(con.nodes)):
        if con.nodes[i].id == new_con.id:
            child = i

    if not child:
        return

    dest = 2 if child == 1 else 1
    if con.nodes[dest].layout == 'splith':
        con.nodes[dest].command('split v')
    move_con(new_con, dest - child)

def new_move_callback(self, e):
    def get_workspace(cnx, e):
        return cnx.get_tree().find_by_id(e.container.id).workspace()

    cnx = Connection()
    wsp = get_workspace(cnx, e)
    if not wsp:
        # This removes problems on i3 start
        return
    new_con = wsp.find_by_id(e.container.id)
    place_node(cnx, wsp, new_con)

i3 = Connection()
i3.on('window::new', new_move_callback)
i3.on('window::move', new_move_callback)
i3.main()
