node 'puppet' {
}
node default {
  lookup('classes', Array[String], 'unique').include
  include $facts['role']
}
