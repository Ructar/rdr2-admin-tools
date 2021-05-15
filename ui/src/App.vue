<template>
	<div>
		<Keypress key-event="keydown" :key-code="33" @success="closeMenu" />
		<Keypress key-event="keydown" :key-code="34" @success="closeCursor" />
		<div class="row justify-end .self-center" v-if="Toggled">
			<div class="col-3">
				<q-card dark>
					<q-card-section style="height: 75px; align-content: center;" class="bg-blue-10 text-white">
						<div class="text-h6">Admin Panel</div>
						<div class="text-subtitle2">by Kole</div>
					</q-card-section>

					<q-card-section>
						<q-list dark bordered seperator>
							<q-item>
								<q-item-section avatar style="align-content: center; align-items: center; align-self: center;">
									<span>Player Coords</span>
								</q-item-section>
								<q-separator vertical />
								<q-item-section style="padding-left: 16px;">
									<q-input :dense="dense" v-model="PlayerCoords" readonly />
								</q-item-section>
							</q-item>
							<q-separator />
							<q-item>
								<q-item-section avatar style="align-content: center; align-items: center; align-self: center;">
									<span>Player Camera</span>
								</q-item-section>
								<q-separator vertical />
								<q-item-section style="padding-left: 16px;">
									<q-input :dense="dense" v-model="PlayerCamera" readonly />
								</q-item-section>
							</q-item>
							<q-separator />
							<q-item>
								<q-item-section avatar style="align-content: center; align-items: center; align-self: center;">
									<span>Player Camera Coords</span>
								</q-item-section>
								<q-separator vertical />
								<q-item-section style="padding-left: 16px;">
									<q-input :dense="dense" v-model="PlayerCameraRotation" readonly />
								</q-item-section>
							</q-item>
						</q-list>
					</q-card-section>
					<q-card-section>
						<q-list dark bordered seperator>
							<q-item>
								<q-item-section avatar style="align-content: center; align-items: center; align-self: center;">
									<span>Entity</span>
								</q-item-section>
								<q-separator vertical />
								<q-item-section style="padding-left: 16px;">
									<q-input :dense="dense" v-model="Entity" readonly />
								</q-item-section>
							</q-item>
							<q-separator />
							<q-item>
								<q-item-section avatar style="align-content: center; align-items: center; align-self: center;">
									<span>Entity Model</span>
								</q-item-section>
								<q-separator vertical />
								<q-item-section style="padding-left: 16px;">
									<q-input :dense="dense" v-model="EntityModel" readonly />
								</q-item-section>
							</q-item>
							<q-separator />
							<q-item>
								<q-item-section avatar style="align-content: center; align-items: center; align-self: center;">
									<span>Entity Coords</span>
								</q-item-section>
								<q-separator vertical />
								<q-item-section style="padding-left: 16px;">
									<q-input :dense="dense" v-model="EntityCoords" readonly />
								</q-item-section>
							</q-item>
							<q-item>
								<q-item-section avatar style="align-content: center; align-items: center; align-self: center;">
									<span>Entity Rotation</span>
								</q-item-section>
								<q-separator vertical />
								<q-item-section style="padding-left: 16px;">
									<q-input :dense="dense" v-model="EntityRotation" readonly />
								</q-item-section>
							</q-item>
							<q-item>
								<q-item-section avatar style="align-content: center; align-items: center; align-self: center;">
									<span>Entity Owner</span>
								</q-item-section>
								<q-separator vertical />
								<q-item-section style="padding-left: 16px;">
									<q-input :dense="dense" v-model="EntityOwner" readonly />
								</q-item-section>
							</q-item>
							<q-item>
								<q-item-section avatar style="align-content: center; align-items: center; align-self: center;">
									<span>Entity Network ID</span>
								</q-item-section>
								<q-separator vertical />
								<q-item-section style="padding-left: 16px;">
									<q-input :dense="dense" v-model="EntityNetworkID" readonly />
								</q-item-section>
							</q-item>
							<q-item>
								<q-item-section avatar style="align-content: center; align-items: center; align-self: center;">
									<span>Entity Health</span>
								</q-item-section>
								<q-separator vertical />
								<q-item-section style="padding-left: 16px;">
									<q-input :dense="dense" v-model="EntityHealth" readonly />
								</q-item-section>
							</q-item>
						</q-list>
					</q-card-section>
					<q-card-section>
						<q-list dark bordered seperator>
							<q-item>
								<q-item-section avatar style="align-content: center; align-items: center; align-self: center;">
									<span>Hit Coords</span>
								</q-item-section>
								<q-separator vertical />
								<q-item-section style="padding-left: 16px;">
									<q-input :dense="dense" v-model="HitCoords" readonly />
								</q-item-section>
							</q-item>
							<q-separator />
							<q-item>
								<q-item-section avatar style="align-content: center; align-items: center; align-self: center;">
									<span>Hit Normal</span>
								</q-item-section>
								<q-separator vertical />
								<q-item-section style="padding-left: 16px;">
									<q-input :dense="dense" v-model="HitNormal" readonly />
								</q-item-section>
							</q-item>
						</q-list>
					</q-card-section>
				</q-card>
			</div>
		</div>
	</div>
</template>

<script>
export default {
	name: "App",
	components: {
		Keypress: () => import('vue-keypress')
	},
	data: () => {
		return {
			dense: true,
			Toggled: true,
			PlayerCoords: null,
			PlayerCamera: null,
			PlayerCameraRotation: null,
			Entity: null,
			EntityModel: null,
			EntityMaterial: null,
			EntityType: null,

			EntityCoords: null,
			EntityRotation: null,

			EntityOwner: null,
			EntityNetworkID: null,
			EntityScript: null,
			EntityHealth: null,

			HitCoords: null,
			HitNormal: null,
		};
	},
	mounted() {
		this.listener = window.addEventListener('message', (event) => {
			var item = event.data;

			if (item.open) {
				this.Toggled = item.open;
				console.log("Toggle Menu");
			}

			if (item.info) {
				this.PlayerCoords = item.info.PlayerCoords;
				this.PlayerCamera = item.info.PlayerCamera;
				this.PlayerCameraRotation = item.info.PlayerCameraRotation;
				this.Entity = item.info.Entity;
				this.EntityModel = item.info.EntityModel;
				this.EntityMaterial = item.info.EntityMaterial;
				this.EntityType = item.info.EntityType;
				this.EntityCoords = item.info.EntityCoords;
				this.EntityRotation = item.info.EntityRotation;
				this.EntityOwner = item.info.EntityOwner;
				this.EntityNetworkID = item.info.EntityNetworkID;
				this.EntityScript = item.info.EntityScript;
				this.EntityHealth = item.info.EntityHealth;
				this.HitCoords = item.info.HitCoords;
				this.HitNormal = item.info.HitNormal;
			}
		});
	},
	methods: {
		closeMenu() {
			console.log("Toggle Menu");
			fetch('http://admin/toggleMenu', {
				method: 'post',
				body: JSON.stringify({}),
			})
		},
		closeCursor() {
			console.log("Toggle Cursor");
			fetch('http://admin/toggleCursor', {
				method: 'post',
				body: JSON.stringify({}),
			})
		},
	}
};

</script>

<style>
#app {
	font-family: Avenir, Helvetica, Arial, sans-serif;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	text-align: center;
	color: #2c3e50;
	margin-top: 60px;
}
.p-panel {
	background-color: white;
}
</style>