{
  "$GMObject":"",
  "%Name":"objRoomChanger",
  "eventList":[
    {"$GMEvent":"v1","%Name":"","collisionObjectId":{"name":"objPlayer","path":"objects/objPlayer/objPlayer.yy",},"eventNum":0,"eventType":4,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"objRoomChanger",
  "overriddenProperties":[],
  "parent":{
    "name":"Warps",
    "path":"folders/Objects/Warps.yy",
  },
  "parentObjectId":null,
  "persistent":false,
  "physicsAngularDamping":0.1,
  "physicsDensity":0.5,
  "physicsFriction":0.2,
  "physicsGroup":1,
  "physicsKinematic":false,
  "physicsLinearDamping":0.1,
  "physicsObject":false,
  "physicsRestitution":0.1,
  "physicsSensor":false,
  "physicsShape":1,
  "physicsShapePoints":[],
  "physicsStartAwake":true,
  "properties":[
    {"$GMObjectProperty":"v1","%Name":"room_to","filters":[
        "GMRoom",
      ],"listItems":[],"multiselect":false,"name":"room_to","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resource":{"name":"rTemplate","path":"rooms/rTemplate/rTemplate.yy",},"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"rTemplate","varType":5,},
    {"$GMObjectProperty":"v1","%Name":"warp_x","filters":[],"listItems":[],"multiselect":false,"name":"warp_x","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"-1","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"warp_y","filters":[],"listItems":[],"multiselect":false,"name":"warp_y","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"-1","varType":0,},
  ],
  "resourceType":"GMObject",
  "resourceVersion":"2.0",
  "solid":false,
  "spriteId":{
    "name":"sprRoomChanger",
    "path":"sprites/sprRoomChanger/sprRoomChanger.yy",
  },
  "spriteMaskId":null,
  "visible":false,
}