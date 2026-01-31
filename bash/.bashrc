
export PATH="$PATH:/home/ki11errabbit/.cabal/bin:/home/ki11errabbit/.local/bin:$PATH:/home/ki11errabbit/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:/home/ki11errabbit/.cargo/bin"

if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

