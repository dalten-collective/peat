<template>
  <v-card
    class="tw-grow tw-p-4 tw-bg-white tw-border tw-border-secondary tw-rounded"
  >
    <div class="tw-flex tw-flex-row tw-my-8">
      <v-card-text>
        <div class="tw-flex tw-flex-row tw-items-center tw-justify-center">


          <div class="tw-flex tw-flex-col tw-w-3/5">
            <div class="tw-border-l tw-border-l-info tw-border-l-4 tw-pl-4 tw-mb-8 tw-text-lg">
              <div class="tw-flex tw-flex-row">
                <div>
                  <p>
                    Peat is a response to a community demand for backing up and
                    restoring social graphs on Urbit. Peat comes as the culmination
                    of a long line of products working against <span class="tw-font-mono">%graph-store</span>. The
                    technology underlying Peat was first built at the turn of
                    2021-2022 to help restore Dalten Collective's chat and was, at
                    the time, called <span class="tw-font-mono">%oger</span>. Peat is vastly superior to our prior
                    effort in <span class="tw-font-mono">%oger</span>, and we think you'll like it.
                  </p>

                  <p class="tw-mt-4">With love,</p>

                  <p><span class="tw-font-bold">Quartus</span></p>
                </div>
              </div>
            </div>

            <div class="mt-4">
              <h1 class="tw-text-3xl tw-mb-6">About</h1>
              <p>
                You can use Peat to back up and restore social graphs on Urbit. Chats, Notebooks, Collections and DMs.
              </p>

              <h2 class="tw-text-xl tw-my-4">Backup / Export</h2>

              <p class="tw-mb-2">
                The <span class="tw-text-info tw-font-bold">LIVE</span> section will list all of the graphs your ship currently knows about.
              </p>

              <p class="tw-mb-2">
                The <span class="tw-text-info tw-font-bold">ON DISK</span> section surveys the contents of Peat's <span class="tw-font-mono">hav/</span> directory. More on this later.
              </p>
              <p>
                Use the <span class="tw-text-info tw-font-bold">EXPORT</span> feature to back up a given graph. An archive of the graph will be created in your <span class="tw-font-mono">/&lt;pier_name&gt;urb/put</span> directory inside of a folder with the name of the resource.
              </p>
              <ul class="tw-list-disc tw-my-2">
                <li>You can perform a single export. Or:</li>
                <li>Set up recurring exports. The above-described folder will be rewritten on each occurance of the scheduled export.</li>
              </ul>

              <h2 class="tw-text-xl tw-my-4">Import / Remake</h2>
              <p class="tw-mb-2">
                <span class="tw-text-info tw-font-bold">REMAKE</span> will allow you to re-create a given graph in a new group with a (maybe) new name.
              </p>

              <p class="tw-mb-2">
                In the <span class="tw-text-info tw-font-bold">ON DISK</span> section, you can <span class="tw-text-info tw-font-bold">IMPORT</span> from a graph from the <span class="tw-font-mono">hav/</span> directory, if you hav anything there. This graph can be restored to an existing group, or Peat can create a new one for you.
              </p>

              <p class="tw-mb-2">
                You can also <span class="tw-text-info tw-font-bold">UPLOAD FROM DISK</span>. Choose a folder that contains a <span class="tw-font-mono">.jam</span> file and import it similarly to the above process.
              </p>

              <h2 class="tw-text-xl tw-my-4">Inter-ship Sharing</h2>

              <p class="tw-mb-2">
                The Peat agent allows you to share and import graphs with remote/pals' ships. This is helpful for re-creating resources that you know about on distant ships that have breached. These tools are not yet supported by this interface, but will be coming soon. Contact someone at Quartus if you plan to use the Dojo to attempt that for now.
              </p>

              <h2 class="tw-text-xl tw-my-4">Help</h2>

              <p>
                You can find us at <span class="tw-font-mono">~mister-hilper-dozzod-dalten/quartus</span>
              </p>
            </div>

          </div>

        </div>
      </v-card-text>
    </div>
  </v-card>
</template>

<script>
export default {};
</script>
