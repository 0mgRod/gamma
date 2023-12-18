return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 30,
  height = 30,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 11,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "Inner",
      firstgid = 1,
      class = "",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 40,
      image = "tiles/Inner.png",
      imagewidth = 1280,
      imageheight = 800,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      wangsets = {},
      tilecount = 1000,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      id = 1,
      name = "Terrain",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      chunks = {
        {
          x = 0, y = 0, width = 4, height = 4,
          data = {
            41, 41, 41, 41,
            41, 41, 41, 41,
            41, 41, 41, 41,
            41, 41, 41, 41
          }
        },
        {
          x = 4, y = 0, width = 4, height = 4,
          data = {
            41, 41, 41, 41,
            41, 41, 41, 41,
            41, 41, 41, 41,
            41, 41, 41, 41
          }
        },
        {
          x = 8, y = 0, width = 4, height = 4,
          data = {
            41, 41, 0, 0,
            41, 41, 0, 0,
            41, 41, 0, 0,
            41, 41, 0, 0
          }
        },
        {
          x = 0, y = 4, width = 4, height = 4,
          data = {
            41, 41, 41, 41,
            41, 41, 41, 41,
            0, 0, 0, 0,
            0, 0, 0, 0
          }
        },
        {
          x = 4, y = 4, width = 4, height = 4,
          data = {
            41, 41, 41, 41,
            41, 41, 41, 41,
            0, 0, 0, 0,
            0, 0, 0, 0
          }
        },
        {
          x = 8, y = 4, width = 4, height = 4,
          data = {
            41, 41, 0, 0,
            41, 41, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0
          }
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      id = 4,
      name = "Path",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      chunks = {
        {
          x = 0, y = 0, width = 4, height = 4,
          data = {
            0, 0, 0, 0,
            0, 281, 282, 282,
            0, 321, 322, 322,
            0, 321, 322, 322
          }
        },
        {
          x = 4, y = 0, width = 4, height = 4,
          data = {
            0, 0, 0, 0,
            282, 282, 282, 282,
            322, 322, 322, 322,
            322, 322, 322, 322
          }
        },
        {
          x = 8, y = 0, width = 4, height = 4,
          data = {
            0, 0, 0, 0,
            283, 0, 0, 0,
            323, 0, 0, 0,
            323, 0, 0, 0
          }
        },
        {
          x = 0, y = 4, width = 4, height = 4,
          data = {
            0, 361, 362, 362,
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0
          }
        },
        {
          x = 4, y = 4, width = 4, height = 4,
          data = {
            362, 362, 362, 362,
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0
          }
        },
        {
          x = 8, y = 4, width = 4, height = 4,
          data = {
            363, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0,
            0, 0, 0, 0
          }
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      id = 5,
      name = "Objects1",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      chunks = {}
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      id = 6,
      name = "Objects2",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      chunks = {}
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      id = 7,
      name = "Objects3",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      chunks = {}
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      id = 8,
      name = "Objects4",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      chunks = {}
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      id = 9,
      name = "Walls",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      chunks = {}
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      id = 10,
      name = "Walls2",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      chunks = {}
    }
  }
}
