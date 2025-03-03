# ipit46 - The IP iterator for IPv4 and IPv6

**Version 1.0**\
Developed by: **joker** ([joker@blackflagcrew.net](mailto\:joker@blackflagcrew.net))\
A simple tool to iterate through IPv4 and IPv6 ranges.

## Features

- Supports both **IPv4** and **IPv6**.
- Iterate through address ranges with simple commands.

## Usage

Run `ipit46` as a binary or using `tclsh`:

```sh
ipit46 -4 <IPv4> <minusIP> <plusIP>
ipit46 -6 <IPv6> <minusIP> <plusIP>
```

Or via Tclsh:

```sh
tclsh ipit46.tcl -4 <IPv4> <minusIP> <plusIP>
tclsh ipit46.tcl -6 <IPv6> <minusIP> <plusIP>
```

## Examples

### **IPv4 Example**

```sh
tclsh ipit46.tcl -4 192.168.0.1 -10 +10
```

Output:

```
192.167.255.247
192.167.255.248
192.167.255.249
192.167.255.250
192.167.255.251
192.167.255.252
192.167.255.253
192.167.255.254
192.167.255.255
192.168.0.0
192.168.0.1
192.168.0.2
192.168.0.3
192.168.0.4
192.168.0.5
192.168.0.6
192.168.0.7
192.168.0.8
192.168.0.9
192.168.0.10
192.168.0.11
```

### **IPv6 Example**

```sh
tclsh ipit46.tcl -6 2001:db8::1 -10 +10
```

### **Running with Tclsh**

```sh
tclsh ipit46.tcl -4 192.168.0.1 -10 +10
```

Same output as above.

## Installation

- **Binary**: Available for **Debian** and other Linux distributions (to be released).
- **Tcl Version**: Can be executed with `tclsh`.

## License

This project is released under **MIT License** – do whatever you want with it but please mention me. ❤️

---

> *ipit46 – because sometimes, you just need an IP.*

