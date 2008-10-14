Nfoiled
=======
The Rubyist's interface to [Ncurses][].

[Ncurses]: <http://www.gnu.org/software/ncurses/> "ncurses - terminal text handling library"

Installing
----------
You can install Nfoiled as a pre-built gem, or as a gem generated directly
from the source.

The easiest way to install Nfoiled is to use [RubyGems][] to acquire the
latest 'release' version from [RubyForge][], using the `gem` command line tool:

    sudo gem install nfoiled # You'll be asked for your account password.

Alternatively, you can acquire it (possibly slightly more up-to-date,
depending on how often I update the gemspec) from GitHub as follows:

    # If you've ever done this before, you don't need to do it now - see http://gems.github.com
    gem sources -a http://gems.github.com
    sudo gem install elliottcable-nfoiled # You'll be asked for your account password.
    
Finally, you can build a gem from the latest source yourself. You need [git][],
as well as [Rake][] and elliottcable's clone of [echoe][]:

    git clone git://github.com/elliottcable/nfoiled.git
    cd nfoiled
    # If you've ever done this before, you don't need to do it now - see http://gems.github.com
    gem sources -a http://gems.github.com
    sudo gem install elliottcable-echoe # You'll be asked for your account password.
    rake install # You'll be asked for your account password.

[git]: <http://git-scm.com/> "git - Fast Version Control System"
[RubyGems]: <http://rubyforge.org/projects/rubygems/> "RubyGems - Ruby package manager"
[RubyForge]: <http://rubyforge.org/projects/nfoiled/> "Nfoiled on RubyForge"
[Rake]: <http://rake.rubyforge.org/> "RAKE - Ruby Make"
[echoe]: <http://github.com/fauna/echoe> "If you don't want to hoe, echoe"

History
-------
As in, "Ncurses, Nfoiled Nagain!". Nfoiled is an object-oriented Ruby wrapper
for [ncurses-ruby][], and therefore, Ncurses. I really got tired of the
idiosyncrasies of Ncurses' API (it's written in a C style, not very clean, and
definitely not object-oriented)... since ncurses-ruby does nothing more than
make the C API available to Ruby as methods, it's no better. While working on
[rat][], I set out to abstract the ncurses-ruby API to a system of objects and
classes, in the truly Ruby style I'm used to. Now I've decided to abstract
this code out and make it available separately... hence Nfoiled!

[ncurses-ruby]: <http://ncurses-ruby.berlios.de/> "ncurses-ruby - access the ncurses library in Ruby"
[rat]: <http://github.com/elliottcable/rat> "rat - terminal chat client"

Contributing
------------
You can contribute bug fixes or new features to Nfoiled by forking the project
on GitHub (you'll need to register for an account first), and sending me a
pull request once you've committed your changes.

Links
-----

- [GitHub](http://github.com/elliottcable/nfoiled "Nfoiled on GitHub") is the
    project's primary repository host, and currently also the project's home
    page
- [RubyForge](http://rubyforge.org/projects/nfoiled "Nfoiled on RubyForge") is
    out primary RubyGem host, as well as an alternative repository host
- [integrity](http://integrit.yreality.net/nfoiled "Nfoiled on yreality's integrity server")
    is out continuous integration server - if the top build on that page is
    green, you can assume the latest git HEAD is safe to run/install/utilize.
- [Gitorious](http://gitorious.org/projects/nfoiled "Nfoiled on Gitorious") is
    an alternative repository host
- [repo.or.cz](http://repo.or.cz/w/nfoiled.git "Nfoiled on repo.or.cz") is
    an alternative repository host

License
-------
Nfoiled is copyright 2008 by elliott cable.

Nfoiled is released under the [GNU General Public License v3.0][gpl], which
allows you to freely utilize, modify, and distribute all Nfoiled's source code
(subject to the terms of the aforementioned license).

[gpl]: <http://www.gnu.org/licenses/gpl.txt> "The GNU General Public License v3.0"