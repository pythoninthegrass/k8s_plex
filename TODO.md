# TODO

* Migrate to [k8s-mediaserver-operator](https://github.com/kubealex/k8s-mediaserver-operator) since transcoding workers aren't available in the Plex Media Server chart
* Debug adding a new server to the existing plex account
  * Tied to the claim token
  * Try removing [existing claim](https://support.plex.tv/articles/204281528-why-am-i-locked-out-of-server-settings-and-how-do-i-get-in/)
* Setup templating for the plex-values.yaml file
* Transcode 1080p down to
  * 720p
  * 480p
  * 360p
* Test
  * kind task error: `"bootstrap.sh": executable file not found in $PATH`
  * Third-party [Plex SDK](https://plexapi.dev/SDKs)
  * Multiple concurrenttranscodes
  * DNS (nginx ingress)
    * Might need to add a DNS record to the host machine
    * Or finally setup caddy. cf:
      * https://github.com/tobyshooters/localhost
      * https://inclouds.space/localhost-domains
